--10 Year Historical Stock Data Analysis 
--Comparing 21 Companies

-- Check for NULL Values	
SELECT A."Date", A."Close",A."Open", A."High" 
from APA A
Where A."Date" is null or A."Close" is null or
		A."Open" is null or A."High" is null

-- Check for Duplicate Values by using Row Numbers
WITH Dupl_CTE AS(
	SELECT *, ROW_NUMBER() OVER (
		PARTITION BY [Open],[High],[Low],[Close],
					[Adj Close],[Volume]
		order by [Date]) row_num
	from APA)
Select * from Dupl_CTE Where row_num > 1


--Check Field Length
Select Count(Distinct [Date]) from APA

Select * from Names
Select * from APA

Select A.[Date],A.[Close] from APA A
Where A.[Date] = '2019-06-19'

-- Join Tables to get Day-wise Close Prices of each Stock
SELECT DISTINCT A."Date", 
		round(A."Close",2) as APA, round(B."Close",2) as BKR, round(C1."Close",2) as COP, round(C2."Close",2) as CTRA, round(C3."Close",2) as CVX, 
		round(D."Close",2) as DVN, round(E."Close",2) as EOG, round(F."Close",2) as FANG, round(H1."Close",2) as HAL, round(H2."Close",2) as HES,
		round(K."Close",2) as KMI, round(M1."Close",2) as MPC, round(M2."Close",2) as MRO, round(O1."Close",2) as OKE,round(O2."Close",2) as OXY,
		round(P1."Close",2) as PSX, round(P2."Close",2) as PXD, round(S."Close",2) as SLB, round(V."Close",2) as VLO, round(W."Close",2) as WMB,
		round(X."Close",2) as XOM
From APA A
Join BKR B on A."Date" = B."Date"
Join COP C1 on A."Date" = C1."Date"
Join CTRA C2 on A."Date" = C2."Date"
Join CVX C3 on A."Date" = C3."Date"
Join DVN D on A."Date" = D."Date"
Join EOG E on A."Date" = E."Date"
Join FANG F on A."Date" = F."Date"
Join HAL H1 on A."Date" = H1."Date"
Join HES H2 on A."Date" = H2."Date"
Join KMI K on A."Date" = K."Date"
Join MPC M1 on A."Date" = M1."Date"
Join MRO M2 on A."Date" = M2."Date"
Join OKE O1 on A."Date" = O1."Date"
Join OXY O2 on A."Date" = O2."Date"
Join PSX P1 on A."Date" = P1."Date"
Join PXD P2 on A."Date" = P2."Date"
Join SLB S on A."Date" = S."Date"
Join VLO V on A."Date" = V."Date"
Join WMB W on A."Date" = W."Date"
Join XOM X on A."Date" = X."Date"

-- Join Tables to get Day-wise High Prices of each Stock
SELECT DISTINCT A."Date", 
		round(A."High",2) as APA, round(B."High",2) as BKR, round(C1."High",2) as COP, round(C2."High",2) as CTRA, round(C3."High",2) as CVX, 
		round(D."High",2) as DVN, round(E."High",2) as EOG, round(F."High",2) as FANG, round(H1."High",2) as HAL, round(H2."High",2) as HES,
		round(K."High",2) as KMI, round(M1."High",2) as MPC, round(M2."High",2) as MRO, round(O1."High",2) as OKE,round(O2."High",2) as OXY,
		round(P1."High",2) as PSX, round(P2."High",2) as PXD, round(S."High",2) as SLB, round(V."High",2) as VLO, round(W."High",2) as WMB,
		round(X."High",2) as XOM
From APA A
Join BKR B on A."Date" = B."Date"
Join COP C1 on A."Date" = C1."Date"
Join CTRA C2 on A."Date" = C2."Date"
Join CVX C3 on A."Date" = C3."Date"
Join DVN D on A."Date" = D."Date"
Join EOG E on A."Date" = E."Date"
Join FANG F on A."Date" = F."Date"
Join HAL H1 on A."Date" = H1."Date"
Join HES H2 on A."Date" = H2."Date"
Join KMI K on A."Date" = K."Date"
Join MPC M1 on A."Date" = M1."Date"
Join MRO M2 on A."Date" = M2."Date"
Join OKE O1 on A."Date" = O1."Date"
Join OXY O2 on A."Date" = O2."Date"
Join PSX P1 on A."Date" = P1."Date"
Join PXD P2 on A."Date" = P2."Date"
Join SLB S on A."Date" = S."Date"
Join VLO V on A."Date" = V."Date"
Join WMB W on A."Date" = W."Date"
Join XOM X on A."Date" = X."Date"

--Creating Tables to save Open, Close, High and Low values
CREATE TABLE Temp_Close(
	ST_Date Date, APA float, BKR float, COP float, CTRA float, CVX float, DVN float, EOG float, FANG float, HAL float, 
	HES float, KMI float, MPC float, MRO float, OKE float, OXY float, PSX float, PXD float, SLB float, VLO float, WMB float, XOM float)

CREATE TABLE Temp_High(
	ST_Date Date, APA float, BKR float, COP float, CTRA float, CVX float, DVN float, EOG float, FANG float, HAL float, 
	HES float, KMI float, MPC float, MRO float, OKE float, OXY float, PSX float, PXD float, SLB float, VLO float, WMB float, XOM float)

CREATE TABLE Temp_Open(
	ST_Date Date, APA float, BKR float, COP float, CTRA float, CVX float, DVN float, EOG float, FANG float, HAL float, 
	HES float, KMI float, MPC float, MRO float, OKE float, OXY float, PSX float, PXD float, SLB float, VLO float, WMB float, XOM float)

CREATE TABLE Temp_Low(
	ST_Date Date, APA float, BKR float, COP float, CTRA float, CVX float, DVN float, EOG float, FANG float, HAL float, 
	HES float, KMI float, MPC float, MRO float, OKE float, OXY float, PSX float, PXD float, SLB float, VLO float, WMB float, XOM float)

-- Inserting into Tables Created
INSERT INTO Temp_Close
	SELECT DISTINCT A."Date", 
		round(A."Close",2) as APA, round(B."Close",2) as BKR, round(C1."Close",2) as COP, round(C2."Close",2) as CTRA, round(C3."Close",2) as CVX, 
		round(D."Close",2) as DVN, round(E."Close",2) as EOG, round(F."Close",2) as FANG, round(H1."Close",2) as HAL, round(H2."Close",2) as HES,
		round(K."Close",2) as KMI, round(M1."Close",2) as MPC, round(M2."Close",2) as MRO, round(O1."Close",2) as OKE,round(O2."Close",2) as OXY,
		round(P1."Close",2) as PSX, round(P2."Close",2) as PXD, round(S."Close",2) as SLB, round(V."Close",2) as VLO, round(W."Close",2) as WMB,
		round(X."Close",2) as XOM
	From APA A
	Join BKR B on A."Date" = B."Date"
	Join COP C1 on A."Date" = C1."Date"
	Join CTRA C2 on A."Date" = C2."Date"
	Join CVX C3 on A."Date" = C3."Date"
	Join DVN D on A."Date" = D."Date"
	Join EOG E on A."Date" = E."Date"
	Join FANG F on A."Date" = F."Date"
	Join HAL H1 on A."Date" = H1."Date"
	Join HES H2 on A."Date" = H2."Date"
	Join KMI K on A."Date" = K."Date"
	Join MPC M1 on A."Date" = M1."Date"
	Join MRO M2 on A."Date" = M2."Date"
	Join OKE O1 on A."Date" = O1."Date"
	Join OXY O2 on A."Date" = O2."Date"
	Join PSX P1 on A."Date" = P1."Date"
	Join PXD P2 on A."Date" = P2."Date"
	Join SLB S on A."Date" = S."Date"
	Join VLO V on A."Date" = V."Date"
	Join WMB W on A."Date" = W."Date"
	Join XOM X on A."Date" = X."Date"

INSERT INTO Temp_High
	SELECT DISTINCT A."Date", 
		round(A."High",2) as APA, round(B."High",2) as BKR, round(C1."High",2) as COP, round(C2."High",2) as CTRA, round(C3."High",2) as CVX, 
		round(D."High",2) as DVN, round(E."High",2) as EOG, round(F."High",2) as FANG, round(H1."High",2) as HAL, round(H2."High",2) as HES,
		round(K."High",2) as KMI, round(M1."High",2) as MPC, round(M2."High",2) as MRO, round(O1."High",2) as OKE,round(O2."High",2) as OXY,
		round(P1."High",2) as PSX, round(P2."High",2) as PXD, round(S."High",2) as SLB, round(V."High",2) as VLO, round(W."High",2) as WMB,
		round(X."High",2) as XOM
	From APA A
	Join BKR B on A."Date" = B."Date"
	Join COP C1 on A."Date" = C1."Date"
	Join CTRA C2 on A."Date" = C2."Date"
	Join CVX C3 on A."Date" = C3."Date"
	Join DVN D on A."Date" = D."Date"
	Join EOG E on A."Date" = E."Date"
	Join FANG F on A."Date" = F."Date"
	Join HAL H1 on A."Date" = H1."Date"
	Join HES H2 on A."Date" = H2."Date"
	Join KMI K on A."Date" = K."Date"
	Join MPC M1 on A."Date" = M1."Date"
	Join MRO M2 on A."Date" = M2."Date"
	Join OKE O1 on A."Date" = O1."Date"
	Join OXY O2 on A."Date" = O2."Date"
	Join PSX P1 on A."Date" = P1."Date"
	Join PXD P2 on A."Date" = P2."Date"
	Join SLB S on A."Date" = S."Date"
	Join VLO V on A."Date" = V."Date"
	Join WMB W on A."Date" = W."Date"
	Join XOM X on A."Date" = X."Date"

INSERT INTO Temp_Open
	SELECT DISTINCT A."Date", 
		round(A."Open",2) as APA, round(B."Open",2) as BKR, round(C1."Open",2) as COP, round(C2."Open",2) as CTRA, round(C3."Open",2) as CVX, 
		round(D."Open",2) as DVN, round(E."Open",2) as EOG, round(F."Open",2) as FANG, round(H1."Open",2) as HAL, round(H2."Open",2) as HES,
		round(K."Open",2) as KMI, round(M1."Open",2) as MPC, round(M2."Open",2) as MRO, round(O1."Open",2) as OKE,round(O2."Open",2) as OXY,
		round(P1."Open",2) as PSX, round(P2."Open",2) as PXD, round(S."Open",2) as SLB, round(V."Open",2) as VLO, round(W."Open",2) as WMB,
		round(X."Open",2) as XOM
	From APA A
	Join BKR B on A."Date" = B."Date"
	Join COP C1 on A."Date" = C1."Date"
	Join CTRA C2 on A."Date" = C2."Date"
	Join CVX C3 on A."Date" = C3."Date"
	Join DVN D on A."Date" = D."Date"
	Join EOG E on A."Date" = E."Date"
	Join FANG F on A."Date" = F."Date"
	Join HAL H1 on A."Date" = H1."Date"
	Join HES H2 on A."Date" = H2."Date"
	Join KMI K on A."Date" = K."Date"
	Join MPC M1 on A."Date" = M1."Date"
	Join MRO M2 on A."Date" = M2."Date"
	Join OKE O1 on A."Date" = O1."Date"
	Join OXY O2 on A."Date" = O2."Date"
	Join PSX P1 on A."Date" = P1."Date"
	Join PXD P2 on A."Date" = P2."Date"
	Join SLB S on A."Date" = S."Date"
	Join VLO V on A."Date" = V."Date"
	Join WMB W on A."Date" = W."Date"
	Join XOM X on A."Date" = X."Date"

INSERT INTO Temp_Low
	SELECT DISTINCT A."Date", 
		round(A."Low",2) as APA, round(B."Low",2) as BKR, round(C1."Low",2) as COP, round(C2."Low",2) as CTRA, round(C3."Low",2) as CVX, 
		round(D."Low",2) as DVN, round(E."Low",2) as EOG, round(F."Low",2) as FANG, round(H1."Low",2) as HAL, round(H2."Low",2) as HES,
		round(K."Low",2) as KMI, round(M1."Low",2) as MPC, round(M2."Low",2) as MRO, round(O1."Low",2) as OKE,round(O2."Low",2) as OXY,
		round(P1."Low",2) as PSX, round(P2."Low",2) as PXD, round(S."Low",2) as SLB, round(V."Low",2) as VLO, round(W."Low",2) as WMB,
		round(X."Low",2) as XOM
	From APA A
	Join BKR B on A."Date" = B."Date"
	Join COP C1 on A."Date" = C1."Date"
	Join CTRA C2 on A."Date" = C2."Date"
	Join CVX C3 on A."Date" = C3."Date"
	Join DVN D on A."Date" = D."Date"
	Join EOG E on A."Date" = E."Date"
	Join FANG F on A."Date" = F."Date"
	Join HAL H1 on A."Date" = H1."Date"
	Join HES H2 on A."Date" = H2."Date"
	Join KMI K on A."Date" = K."Date"
	Join MPC M1 on A."Date" = M1."Date"
	Join MRO M2 on A."Date" = M2."Date"
	Join OKE O1 on A."Date" = O1."Date"
	Join OXY O2 on A."Date" = O2."Date"
	Join PSX P1 on A."Date" = P1."Date"
	Join PXD P2 on A."Date" = P2."Date"
	Join SLB S on A."Date" = S."Date"
	Join VLO V on A."Date" = V."Date"
	Join WMB W on A."Date" = W."Date"
	Join XOM X on A."Date" = X."Date"

-- Sample SQL Query to join multiple rows, repeat for all 21
SELECT A."Date", round(A."Close",2) as APA, round(B."Close",2) as BKR,round(C1."Close",2) as COP From APA A
Inner Join BKR B on A."Date" = B."Date"
Inner Join COP C1 on A."Date" = C1."Date"

-- Stock High Price Month, Year-wise
Select DATEPART(year, ST_Date) as Yearly,DATEPART(month, ST_Date) as Monthly,
	Max(APA),MAX(BKR),MAX(COP), MAX(CTRA), MAX(CVX), MAX(DVN), MAX(EOG), MAX(FANG), MAX(HAL), MAX(HES), 
	MAX(KMI), MAX(MPC), MAX(MRO), MAX(OKE), MAX(OXY), MAX(PSX), MAX(PXD), MAX(SLB), MAX(VLO), MAX(WMB), MAX(XOM)
from Temp_High
group by DATEPART(year, ST_Date),DATEPART(month,ST_Date)
order by 1,2


Select DATEPART(year,[Date]) as Yearly,DATEPART(month,[Date]) as Monthly,Max([High]) as Y_High from APA
group by DATEPART(year,[Date]),DATEPART(month,[Date])
order by 1,2


--Find Average of 10-Year Highest Stock Prices for 21 Companies
WITH Max_Tab As(
Select DATEPART(year, ST_Date) as Yearly,
	Max(APA) as APA,MAX(BKR) as BKR,MAX(COP) as COP, MAX(CTRA) as CTRA, MAX(CVX) as CVX, MAX(DVN) as DVN, MAX(EOG) as EOG, 
	MAX(FANG) as FANG, MAX(HAL) as HAL, MAX(HES) as HES, MAX(KMI) as KMI, MAX(MPC) as MPC, MAX(MRO) as MRO, MAX(OKE) as OKE, 
	MAX(OXY) as OXY, MAX(PSX) as PSX, MAX(PXD) as PXD, MAX(SLB) as SLB, MAX(VLO) as VLO, MAX(WMB) as WMB, MAX(XOM) as XOM
from Temp_High
group by DATEPART(year, ST_Date)) 
Select AVG(APA) as APA,AVG(BKR) as BKR,AVG(COP) as COP, AVG(CTRA) as CTRA, AVG(CVX) as CVX, AVG(DVN) as DVN, AVG(EOG) as EOG, 
		AVG(FANG) as FANG, AVG(HAL) as HAL, AVG(HES) as HES, AVG(KMI) as KMI, AVG(MPC) as MPC, AVG(MRO) as MRO, AVG(OKE) as OKE, 
		AVG(OXY) as OXY, AVG(PSX) as PSX, AVG(PXD) as PXD, AVG(SLB) as SLB, AVG(VLO) as VLO, AVG(WMB) as WMB, AVG(XOM) as XOM
from Max_Tab
