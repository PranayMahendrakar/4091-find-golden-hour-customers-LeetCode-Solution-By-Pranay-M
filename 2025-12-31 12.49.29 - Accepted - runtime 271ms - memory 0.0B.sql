# Write your MySQL query statement below
WITH order_stats AS (
    SELECT 
            customer_id,
                    COUNT(*) AS total_orders,
                            SUM(CASE 
                                        WHEN HOUR(order_timestamp) BETWEEN 11 AND 13 
                                                      OR HOUR(order_timestamp) BETWEEN 18 AND 20 THEN 1 
                                                                  ELSE 0 
                                                                          END) AS peak_orders,
                                                                                  SUM(CASE WHEN order_rating IS NOT NULL THEN 1 ELSE 0 END) AS rated_orders,
                                                                                          AVG(CASE WHEN order_rating IS NOT NULL THEN order_rating ELSE NULL END) AS avg_rating
                                                                                              FROM restaurant_orders
                                                                                                  GROUP BY customer_id
                                                                                                  )
                                                                                                  SELECT 
                                                                                                      customer_id,
                                                                                                          total_orders,
                                                                                                              ROUND(peak_orders * 100.0 / total_orders) AS peak_hour_percentage,
                                                                                                                  ROUND(avg_rating, 2) AS average_rating
                                                                                                                  FROM order_stats
                                                                                                                  WHERE total_orders >= 3
                                                                                                                      AND peak_orders * 100.0 / total_orders >= 60
                                                                                                                          AND avg_rating >= 4.0
                                                                                                                              AND rated_orders * 100.0 / total_orders >= 50
                                                                                                                              ORDER BY average_rating DESC, customer_id DESC;