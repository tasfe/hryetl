SELECT *
FROM tss.t_payment_order@kjtdb p
INNER JOIN tss.t_pay_method@kjtdb t
ON p.payment_voucher_no = t.payment_voucher_no
WHERE p.gmt_submit     >= TRUNC(SYSDATE, 'mm')
AND p.gmt_submit        < add_months(TRUNC(SYSDATE, 'mm'), 1)
;