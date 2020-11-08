select * from Sales.SalesOrderHeader;
select * from Sales.SalesOrderDetail;

select soh.OrderDate, soh.SubTotal, sst.Name as TerritoryName, psm.Name as ShipMethodName, soh.Freight as DeliverCost, soh.OnlineOrderFlag as online
from Sales.SalesOrderHeader as soh
left join Sales.SalesTerritory as sst
on soh.TerritoryID = sst.TerritoryID
left join Purchasing.ShipMethod as psm
on soh.ShipMethodID = psm.ShipMethodID
where year(soh.OrderDate) = 2012;

select Color, count(ProductID) as ProductCount
from Production.Product as pp
group by Color; --2a

select pc.Name as CategoryName, count(pp.ProductID) as ProductCount
from Production.Product as pp
left join Production.ProductSubcategory as ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
left join Production.ProductCategory as pc
on ps.ProductCategoryID = pc.ProductCategoryID
group by pc.Name; --2b

select sst.Name as Territory, sum(soh.SubTotal) as SalesValue
from Sales.SalesOrderHeader as soh
left join Sales.SalesTerritory as sst
on soh.TerritoryID = sst.TerritoryID
group by sst.Name; --2c

declare @columns NVARCHAR(max) = '';
select @columns += QUOTENAME(sst.Name) + ','
from Sales.SalesOrderHeader as soh
left join Sales.SalesTerritory as sst
on soh.TerritoryID = sst.TerritoryID
group by sst.Name;

set @columns = left(@columns, len(@columns) - 1);

print @columns;

select * from (
    select sst.Name as Territory, soh.SubTotal as SalesValue
    from Sales.SalesOrderHeader as soh
    left join Sales.SalesTerritory as sst
    on soh.TerritoryID = sst.TerritoryID
)t
pivot(
    sum(SalesValue)
    for Territory in([Germany],[Australia],[United Kingdom],[Northeast],[Southwest],[Canada],[France],[Northwest],[Southeast],[Central])
) as pivot_table;




DECLARE @columns2 NVARCHAR(max) = '';
SELECT @columns2 += QUOTENAME(Color) + ','
FROM Production.Product
ORDER BY Color;

SET @columns2 = LEFT(@columns2, len(@columns2) - 1);

PRINT @columns2;




DECLARE
    @col NVARCHAR(max) = '',
    @sql NVARCHAR(max) = '';

SELECT
    @col += QUOTENAME(Color) + ','
FROM
    Production.Product
ORDER BY
    Color;

SET @col = LEFT(@col, len(@col) - 1);

SET @sql ='
select * from (
    select
        Color,
        ProductID
    from
        Production.Product
)t
pivot(
    count(PoductID)
    for Color in ('+ @col +')
)as pivot_table;';

EXECUTE sp_executesql @sql;




select * from Production.Product;