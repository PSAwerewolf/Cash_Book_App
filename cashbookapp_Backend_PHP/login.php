<?php
include "config.php";

// Get input values
$shopId = $_POST['shop_id'] ?? '';
$userId = $_POST['user_id'] ?? '';
$userPassword = $_POST['user_password'] ?? '';

$response = [];

// Check if input values are not empty
    // Prepare SQL statement with placeholders
    $sql = "SELECT productDB_username, ProductDB_password FROM users WHERE user_id = ? AND shop_id = ? AND user_password = ?";

    // Initialize a statement
    $stmt = $con->prepare($sql);

    if ($stmt) {
        // Bind the input values to the statement as parameters
        $stmt->bind_param("sss", $userId, $shopId, $userPassword);

        // Execute the statement
        $stmt->execute();

        // Get the result
        $res = $stmt->get_result();

        if ($res->num_rows > 0) {
            // Fetch the result as an associative array
            while ($row = $res->fetch_assoc()) {
                $response[] = $row;
            }
            $response['status'] = "Login Successful";
        } else {
            $response['status'] = 'Error Fetching Data';
        }

        // Close the statement
        $stmt->close();
    } else {
        $response['status'] = 'SQL Preparation Error';
    }


// Return response as JSON
echo json_encode($response);

// Close the database connection
$con->close();
?>
