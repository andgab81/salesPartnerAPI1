<?php

class Database
{
  private mysqli $conn;
  /**
   * Summary of __construct
   * @param string $hostname
   * @param string $user
   * @param string $password
   * @param string $dbname
   */
  public function __construct(
    private string $hostname = "localhost",
    private string $user = "salesman",
    private string $password = "Partner2023",
    private string $dbname = "salespartner"
  ) {
    $this->conn = new mysqli($this->hostname, $this->user, $this->password, $this->dbname);
  }

  public function getConnection() : mysqli
  {
    return $this->conn;
  }
  public function getAllClients() : array
  {
    $sql = "SELECT *
            FROM clienti
            ORDER BY nume";
    $response = mysqli_query($this->conn, $sql);

    $data = mysqli_fetch_all($response, MYSQLI_ASSOC);

    return $data;

  }

  public function getClientByPhone(string $telefon) : int|false
  {
    $sql = "SELECT *
            FROM clienti
            WHERE telefon = '$telefon'";
    // echo "getClientByEmail: ", $sql, "\n";

    $response = mysqli_query($this->conn, $sql);
    $row = mysqli_fetch_assoc($response);

    if (! $row) {
      return false;
    } else {
      return $row['id'];
    }
  }

  public function getClientByEmail(string $email) : int|false
  {
    $sql = "SELECT *
            FROM clienti
            WHERE email = '$email'";
    // echo "getClientByEmail: ", $sql, "\n";

    $response = mysqli_query($this->conn, $sql);

    $row = mysqli_fetch_assoc($response);

    if (! $row) {
      // echo 'false';
      return false;
    } else {
      // echo $row['id'];
      return $row['id'];
    }
  }

  public function createClient(string $nume, string $prenume, string $email, string $telefon) : int
  {
    $sql = "INSERT INTO clienti (nume, prenume, email, telefon) VALUES ('" . $nume . "', '" . $prenume . "', '" . $email . "', '" . $telefon . "')";
    // echo "createClient: ", $sql, "\n";
    mysqli_query($this->conn, $sql);

    return $this->conn->insert_id;
  }

  public function createLead(string $clientID, string $mesaj) : int
  {
    $sql = "INSERT INTO leads (id_client, mesaj) VALUES (" . $clientID . ", '" . $mesaj . "')";
    // echo "createLead: ", $sql, "\n";

    mysqli_query($this->conn, $sql);

    return $this->conn->insert_id;
  }

  public function getCarsByTypeAndDate(string $type = "toate", string $date = "toate") : array|false
  {
    $sql = "SELECT * FROM masini";

    $conditions = [];
    if ($type != 'toate') {
      $conditions[] = " tip_stoc = '$type'";
    }
    if ($date != 'toate') {
      $date = strtotime($date);
      $date = date('Y-m-d', $date);
      $conditions[] = " introdus > '$date'";
    }
    if (sizeof($conditions) > 0) {
      $sql = $sql . " WHERE " . implode(" AND", $conditions);
    }
    $response = mysqli_query($this->conn, $sql);
    if (! $response) {
      return false;
    } else {
      $data = mysqli_fetch_all($response, MYSQLI_ASSOC);
      return $data;
    }
  }
}