<?php

include "configProductSales.php";

$expCat = $_POST['expense_desc'];
//$expCat = 'asd';
try {
    // Check if the value already exists
    $checkStmt = $con->prepare("SELECT COUNT(*) FROM expense_category WHERE expense_desc = ?");
    $checkStmt->bind_param("s", $expCat);
    $checkStmt->execute();
    $checkStmt->bind_result($count);
    $checkStmt->fetch();
    $checkStmt->close();

    if ($count > 0) {
        echo "The expense description already exists.";
    } else {
        // Prepare the insert statement
        $stmt = $con->prepare("INSERT INTO expense_category (expense_desc) VALUES (?)");
        $stmt->bind_param("s", $expCat);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            echo "Success";
        } else {
            echo "Failed";
        }

        $stmt->close();
    }
} catch (Exception $e) {
    error_log($e->getMessage());
    echo "An error occurred. Please try again later.";
}

$con->close();



 ?>
