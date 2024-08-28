<?php
  include "configProductSales.php";

  $sql = 'select * from product_sales order by added_date asc;';

  $res = $con ->query($sql);
  $result=array();

  if($res -> num_rows > 0){
    while($row= $res->fetch_assoc()){
      $result[] = $row;
    }
  }

  echo json_encode($result);

 ?>
