
---------------------Primer consulta---------------------
select
      items_tl.inventory_item_id        AS     organization_id_item,
      egp.organization_id          AS     organization_id_inv,
      egp.inventory_item_status_code AS   code_inventory_item_status,
      egp.item_number             AS      sku,
      inv.organization_code        AS     code_inv_organization,
      assignments.category_id      AS     category,
      cat_tl.description              AS     description,
      cat_tl.category_name         AS     category_name
from
    egp_system_items_b              egp,          
    fusion.inv_org_parameters       inv,          
    egp_item_cat_assignments        assignments,  
    egp_system_items_tl             items_tl,      
    egp_category_sets_b             sets,          
    egp_categories_tl               cat_tl

where 1=1
and
    egp.organization_id           = inv.organization_id
and
    assignments.organization_id   = egp.organization_id
and
    sets.public_catalog            = 'Y'
and
    assignments.organization_id   = inv.organization_id
and
    items_tl.organization_id      = egp.organization_id
and
    assignments.inventory_item_id = egp.inventory_item_id
and
    items_tl.inventory_item_id    = egp.inventory_item_id
and
    assignments.category_set_id   = sets.category_set_id
and
    assignments.category_id       = cat_tl.category_id
and
    items_tl.LANGUAGE=USERENV('LANG')
and
    cat_tl.LANGUAGE = USERENV('LANG')
and
    inv.organization_code = 'XX_INV_ORG_CBSSH'
and
    egp.inventory_item_status_code = 'Active'
and
    egp.item_number                in( 'GN0258','TF0144','SH2777', 'CR0101')