SELECT * FROM `document_master` WHERE `document_name` LIKE 'karagir_nave'; 
SELECT * FROM `document_header` WHERE `fk_document_type` LIKE 'shop_metal_jama'; 
SELECT * FROM `document_header` ORDER BY 1 DESC;

SELECT * FROM `document_header` WHERE `pk_document_header_id` = '70' ORDER BY 1 DESC; 
SELECT * FROM `document_stock_details` WHERE `fk_document_header_id` = '70'; 

SELECT * FROM `item_details` WHERE `pk_item_details_id` IN (SELECT `fk_item_detail_id` FROM `document_stock_details` WHERE `fk_document_header_id` = '70');

SELECT * FROM `item_details` WHERE `parent_id` IN (SELECT `pk_item_details_id` FROM `item_details` WHERE `pk_item_details_id` IN (SELECT `fk_item_detail_id` FROM `document_stock_details` WHERE `fk_document_header_id` = '70'));

SELECT * FROM `item_location_closing_balances`;

SELECT * FROM `item_details` WHERE `pk_item_details_id`>=5143370 AND pk_item_details_id <= 51700;

SELECT * FROM `document_header`  WHERE fk_ptr_header='43370';
SELECT * FROM `document_stock_details` WHERE source_doc_no='43370';


SELECT*FROM `item_category_master` WHERE `fk_item_master_id` IN (SELECT `pk_item_master_id` FROM `item_master` WHERE `fk_product_classification_group_id` = '2'); 



-- Data deletion

SET FOREIGN_KEY_CHECKS=0;
DELETE FROM document_passing_status where `fk_document_header_id` IN (SELECT pk_document_header_id FROM `document_header` WHERE `fk_document_type` IN ('karagir_nave','shop_order_completion','shop_order_cancelation','karagir_order_cancelation','karagir_metal_jama','karagir_metal_nave','shop_metal_outward','karagir_order_reject','order_rejection','karagir_jama','shop_metal_jama','shop_order_collection' ));

DELETE FROM `item_details` WHERE `pk_item_details_id` IN (SELECT `fk_item_detail_id` FROM `document_stock_details` WHERE `fk_document_header_id` IN (SELECT pk_document_header_id FROM `document_header` WHERE `fk_document_type` IN ('karagir_nave','shop_order_completion','shop_order_cancelation','karagir_order_cancelation','karagir_metal_jama','karagir_metal_nave','shop_metal_outward','karagir_order_reject','order_rejection','karagir_jama','shop_metal_jama','shop_order_collection' )));

SET FOREIGN_KEY_CHECKS=1;
DELETE FROM `document_stock_details` WHERE `fk_document_header_id` IN (SELECT pk_document_header_id FROM `document_header` WHERE `fk_document_type` IN ('karagir_nave','shop_order_completion','shop_order_cancelation','karagir_order_cancelation','karagir_metal_jama','karagir_metal_nave','shop_metal_outward','karagir_order_reject','order_rejection','karagir_jama','shop_metal_jama','shop_order_collection' ));

DELETE FROM `stock_tally_result` WHERE `fk_document_header_id` IN (SELECT pk_document_header_id FROM `document_header` WHERE `fk_document_type` IN ('karagir_nave','shop_order_completion','shop_order_cancelation','karagir_order_cancelation','karagir_metal_jama','karagir_metal_nave','shop_metal_outward','karagir_order_reject','order_rejection','karagir_jama','shop_metal_jama','shop_order_collection' ));

DELETE FROM `gift_voucher_transaction_details` WHERE `fk_gift_voucher_details_id` IN (SELECT `pk_gift_voucher_details_id`FROM `gift_voucher_details` WHERE `fk_document_header_id` IN ( SELECT `pk_document_header_id` FROM `document_header` WHERE `fk_document_type` IN ('karagir_nave','shop_order_completion','shop_order_cancelation','karagir_order_cancelation','karagir_metal_jama','karagir_metal_nave','shop_metal_outward','karagir_order_reject','order_rejection','karagir_jama','shop_metal_jama','shop_order_collection' )));

DELETE FROM `gift_voucher_details` WHERE `fk_document_header_id` IN ( SELECT `pk_document_header_id` FROM `document_header` WHERE `fk_document_type` IN ('karagir_nave','shop_order_completion','shop_order_cancelation','karagir_order_cancelation','karagir_metal_jama','karagir_metal_nave','shop_metal_outward','karagir_order_reject','order_rejection','karagir_jama','shop_metal_jama','shop_order_collection' ));

DELETE FROM `document_header` WHERE `fk_document_type` IN ('karagir_nave','shop_order_completion','shop_order_cancelation','karagir_order_cancelation','karagir_metal_jama','karagir_metal_nave','shop_metal_outward','karagir_order_reject','order_rejection','karagir_jama','shop_metal_jama','shop_order_collection' );

 truncate table `item_location_closing_balances`;
 truncate table `shop_karagir_balances`;
 
  
DELETE FROM `document_stock_details`
 WHERE `fk_from_loc_id` NOT IN (SELECT pk_location_master_id FROM location_master )
 OR
 `fk_to_loc_id` NOT IN (SELECT pk_location_master_id FROM location_master );
 


SELECT * FROM item_location_closing_balances WHERE `fk_item_master_id`=2709
AND `fk_item_category_id`=515
AND `fk_purity_id`=14
ORDER BY DATE DESC;

-- Save This  Query For Change Database Password
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('159Diagonal');

