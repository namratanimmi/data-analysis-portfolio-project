
--- KPIs ---

Use Bank_Churn;

SELECT COUNT(CustomerId) as Total_Customers from Bank_Churn;

SELECT COUNT(CustomerId) as Churned_Customers from Bank_Churn where Exited = 1;

SELECT ROUND(SUM(Exited)*100.0/COUNT(Exited),2) as Churn_Rate from Bank_Churn ;

SELECT 100-(SUM(Exited)*100.0/COUNT(Exited) )as Retention_Rate from Bank_Churn;

SELECT SUM(Balance) as Lost_Balance from Bank_Churn where Exited = 1;

SELECT  
   CASE 
      WHEN Exited = 1 THEN 'Churned Customer'
      ELSE 'Retained Customer'
      END AS Customer_Type ,
   ROUND(AVG(Balance),2)  AS Avg_Balance
from Bank_Churn 
GROUP BY Exited;



--- VISUALS ---

--- 1 ---

SELECT Geography , 
       COUNT(CustomerId) as Num_of_Customers, 
       ROUND(SUM(Exited)*100.0/COUNT(Exited),2) as Churn_Rate 
from Bank_Churn 
GROUP BY Geography;


ALTER TABLE Bank_Churn 
ADD Age_Gr VARCHAR(20);

UPDATE Bank_Churn
SET Age_Gr = CASE 
 WHEN Age < 40 THEN 'Under 40'
 WHEN Age BETWEEN 40 AND 65 THEN '40 - 65'
 WHEN Age BETWEEN 66 AND  80 THEN '66-80'
ELSE '80+'
END;

--- 2 ---

SELECT Age_Gr as Age_Group , 
    COUNT(CustomerId) as Num_of_Customers , 
    SUM(Exited)*100.0/COUNT(Exited) as Churn_Rate 
from Bank_Churn 
GROUP BY Age_Gr;

--- 3 ---

SELECT CASE WHEN Exited= 1 THEN 'Churned' ELSE 'Retained' END AS Customer_Type , 
    COUNT(CASE WHEN Exited = 1 THEN Exited ELSE Exited END) as Num_of_Customers , 
    (COUNT(CASE WHEN Exited = 1 THEN Exited ELSE Exited END)*100.0/(SELECT COUNT(*) FROM Bank_Churn)) AS Percentage_of_Customers
    FROM Bank_Churn GROUP BY Exited ;

--- 4 ---
ALTER TABLE Bank_Churn
ADD Activity Varchar(20);

UPDATE Bank_Churn
SET Activity = CASE
      WHEN IsActiveMember = 1 THEN 'Active' 
      ELSE 'InActive'
      END ;

ALTER TABLE Bank_Churn
ADD Balance_Tier VARCHAR(30)

UPDATE Bank_Churn
SET Balance_Tier = CASE
    WHEN Balance = 0 THEN 'Zero'
    WHEN Balance BETWEEN 1 AND 75000 THEN 'Low (1$-75K$)'
    WHEN Balance BETWEEN 75001 AND 150000 THEN 'Medium (75K$-150K$)'
    WHEN Balance > 150000 THEN 'High (150K$)'
    END

    SELECT Balance_Tier , Activity , ROUND(SUM(Exited)*100.0/COUNT(Exited),2) as Churn_Rate 
    FROM Bank_Churn 
    GROUP BY Balance_Tier, Activity
    ORDER BY Balance_Tier, Activity;



