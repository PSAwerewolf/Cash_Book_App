<?php
include 'configProductSales.php';

// Get POST data
$productName = $_POST['product_name'];
$unitPrice = $_POST['unit_price'];



try {
    // Check if the product already exists
    $stmt = $con->prepare("SELECT * FROM product_items WHERE product_name = ?");
    $stmt->bind_param("s", $productName);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Product exists, update the unit price
        $stmt = $con->prepare("UPDATE product_items SET unit_price = ? WHERE product_name = ?");
        $stmt->bind_param("ds", $unitPrice, $productName);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            echo json_encode("Product price updated successfully");
        } else {
            echo json_encode("No changes made to the product price");
        }
    } else {
        // Product does not exist, insert the new product
        $stmt = $con->prepare("INSERT INTO product_items (product_name, unit_price) VALUES (?, ?)");
        $stmt->bind_param("sd", $productName, $unitPrice);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            echo json_encode("Product added successfully");
        } else {
            echo json_encode("Failed to add product");
        }
    }

    $stmt->close();
} catch (Exception $e) {
    echo json_encode("Error: " . $e->getMessage());
}

$con->close();


 ?>
