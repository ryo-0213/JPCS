﻿--DROP VIEW adempiere.JP_Estimation_Line_vt;
CREATE OR REPLACE VIEW adempiere.JP_Estimation_Line_vt AS 
SELECT 
ol.JP_Estimation_ID
,ol.JP_EstimationLine_ID
,ol.AD_Client_ID
,ol.AD_Org_ID
,ol.Line
,ol.M_Product_ID
,ol.C_Charge_ID
,CASE WHEN ol.M_Product_ID > 0 THEN p.Value ELSE '' END AS ProductValue
,CASE WHEN ol.M_Product_ID > 0 THEN p.Name ELSE c.Name END AS ProductName
,ol.QtyEntered
,ol.QtyOrdered
,ol.C_UOM_ID
,CASE WHEN ol.M_Product_ID > 0 THEN puom.C_UOM_ID ELSE 0 END AS M_Product_C_UOM_ID
,ol.PriceEntered
,ol.PriceActual
,ol.PriceList
,ol.Discount
,ol.C_Tax_ID
,t.TaxIndicator AS TaxName
,ol.LineNetAmt
,ol.Description
,tt.AD_Language AS AD_Language
,ol.JP_TaxBaseAmt
,ol.JP_TaxAmt
,CASE WHEN ol.M_Product_ID > 0 THEN p.Value || ':' || p.Name ELSE c.Name END AS ProductValueName

FROM adempiere.JP_EstimationLine ol
	left Outer Join adempiere.M_Product p on(ol.M_Product_ID = p.M_Product_ID)
		left Outer JOIN adempiere.C_UOM puom on(p.C_UOM_ID = puom.C_UOM_ID)
	left Outer Join adempiere.C_Charge c on(ol.C_Charge_ID = c.C_Charge_ID)
	INNER JOIN adempiere.C_Tax t on(ol.C_Tax_ID = t.C_Tax_ID)
		INNER JOIN adempiere.C_Tax_Trl tt on(t.C_Tax_ID = tt.C_Tax_ID)