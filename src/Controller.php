<?php
class Controller
{

  public function __construct(private Database $database)
  {

  }

  public function processRequest(string $method, string $resource, string $type, string $date) : void
  {
    switch ($resource) {
      case 'contact':
        if ($method == "POST") {
          $inputData = (array) json_decode(file_get_contents("php://input"));

          $errors = $this->getValidationErrors($inputData);

          if (empty($errors)) {
            $clientID = $this->database->getClientByEmail($inputData['email']);
            if (! $clientID) {
              $clientID = $this->database->getClientByPhone($inputData['telefon']);
            }
            if (! $clientID) {
              $clientID = $this->database->createClient($inputData['nume'], $inputData['prenume'], $inputData['email'], $inputData['telefon']);
            }

            $leadID = $this->database->createLead($clientID, $inputData['mesaj']);
            $this->respondCreatedLead($leadID);
          } else {
            $this->respondNotCreatedLead($errors);
          }
        } else {
          $this->respondMethodNotAllowed("POST");
        }
        break;
      case 'masini':
        if ($method == "GET") {
          switch ($type) {
            case 'noi':
              $data = $this->database->getCarsByTypeAndDate("nou", $date);
              echo json_encode($data);
              break;

            case 'vechi':
              $data = $this->database->getCarsByTypeAndDate("utilizat", $date);
              echo json_encode($data);
              break;

            case 'toate':
              $data = $this->database->getCarsByTypeAndDate($date);
              echo json_encode($data);
              break;

            default:
              $this->respondTypeNotAllowed();
              break;
          }
        } else {
          $this->respondMethodNotAllowed("GET");
        }
        break;
      default:
        $this->respondResourceNotAvailable("masini, contact");
    }

  }

  private function respondTypeNotAllowed() : void
  {
    http_response_code(500);
    echo json_encode(["errors" => ["Tip de masina invalid"]]);
  }

  private function respondMethodNotAllowed(string $allowed_methods) : void
  {
    http_response_code(500);
    header("Allowed: $allowed_methods");
    echo json_encode(["errors" => ["Metoda nu este permisa"]]);
  }

  private function respondResourceNotAvailable(string $allowed_resources) : void
  {
    http_response_code(500);
    header("Allowed: $allowed_resources");
    echo json_encode(["errors" => ["Resursa nu a fost gasita"]]);
  }

  private function respondCreatedLead(string $id) : void
  {
    http_response_code(200);
    echo json_encode(["message" => "Mesajul a fost inregistrat"]);
  }

  private function respondNotCreatedLead(array $errors) : void
  {
    http_response_code(500);
    echo json_encode(["errors" => $errors]);
  }

  private function getValidationErrors(array $data) : array
  {
    $keys = ['nume', 'prenume', 'telefon', 'email'];
    $errors = [];
    foreach ($keys as $key) {
      if (! array_key_exists($key, $data) || empty($data[$key])) {
        $errors[] = "$key is required";
      }
    }
    return $errors;
  }

}