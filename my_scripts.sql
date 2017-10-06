-- My queries

SELECT *FROM document_account_details WHERE (credit_amount=20 OR debit_amount=20);

SELECT*FROM document_header WHERE pk_document_header_id IN(SELECT fk_document_header_id FROM document_account_details WHERE (credit_amount=3.67 OR debit_amount=3.67));

SELECT*FROM document_header WHERE pk_document_header_id IN(SELECT fk_document_header_id FROM document_account_details WHERE (credit_amount=20 OR debit_amount=20))AND is_cancelled= 'N';

SELECT * FROM `document_header` WHERE series ='IUC'; AND doc_no =4;

SELECT * FROM `item_details` WHERE `pk_item_details_id` IN (SELECT fk_item_detail_id FROM document_stock_details WHERE fk_document_header_id IN 
(SELECT pk_document_header_id FROM `document_header` WHERE series ='MSC' AND doc_no =4 ));
-- concate script
UPDATE `item_master` SET `item_name` = CONCAT(`item_name`," NEW") WHERE `pk_item_master_id` IN(166,561,3845,554,460,405);  
UPDATE `item_master` SET `is_active` = 'N' WHERE `pk_item_master_id` IN(166,561,3845,554,460,405);  

SELECT dh.pk_document_header_id, 
dh.series, 
dh.doc_no,
 id.barcode_no,
 id.fk_current_location, 
 id.current_status,
 -- dad.transaction_type,
-- dad.fk_account_id
FROM document_header dh,item_details id, document_stock_details dsd, document_account_details dad 
WHERE dh.pk_document_header_id=dsd.fk_document_header_id 
AND dad.fk_document_header_id= dh.pk_document_header_id
AND dsd.fk_item_detail_id=id.pk_item_details_id 
AND dsd.fk_document_header_id=7;


SELECT dh.pk_document_header_id, 
dh.series, 
dh.doc_no,
 id.barcode_no,
 id.fk_current_location, 
 id.current_status
FROM document_header dh,item_details id, document_stock_details dsd
WHERE dh.pk_document_header_id=dsd.fk_document_header_id 
AND dsd.fk_item_detail_id=id.pk_item_details_id 
AND dsd.fk_document_header_id=7;

-- find document from item id 
SELECT*FROM document_header WHERE pk_document_header_id IN(SELECT fk_document_header_id FROM document_stock_details WHERE `fk_item_detail_id` IN
( SELECT pk_item_details_id FROM item_details 
WHERE current_status= 'Available' AND fk_item_id = 3853 ));

SELECT pm.`display_name` AS 'purityName',SUM(id.`pcs`) AS 'Pcs',SUM(id.`gross_wt`) AS 'GrossWt',SUM(id.`net_wt`) AS NetWt,ROUND((SUM(id.`net_wt`)*pm.`inventory_purity`)/100,3) AS 'FineWt'
		FROM `item_details` id,`purity_master` pm,`item_master` im
		WHERE id.`fk_purity_id` = pm.`pk_purity_master_id` 
		AND id.`fk_item_id` = im.`pk_item_master_id`
		AND id.`fk_item_id` = '462'
		AND id.`current_status` = 'Available'
		AND id.fk_branch_id = 173
		-- and id.`fk_current_location` = '283'
		-- and im.`fk_product_classification_group_id` in (p_pcg_id) 
		GROUP BY id.`fk_purity_id` 
		ORDER BY id.purity ASC;