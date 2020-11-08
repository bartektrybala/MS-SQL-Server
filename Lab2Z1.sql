select * from Person.Address;

select AddressLine1, City from Person.Address;

-- select AddressLine1, City from Person.Address;

select * from Production.Product;

select ProductID, Color, ListPrice from Production.Product; --4a

select Name, ListPrice from Production.Product where Color='Red'; --4bi

select Name, ListPrice from Production.Product where ListPrice >100; --4bii

select Name, ListPrice from Production.Product where ListPrice > 1000 and Color='Red'; --4biii

select * from Production.Product;
select * from Production.ProductSubcategory;
select * from Production.ProductCategory;

select pp.Name as Name, ps.Name as SubCategory
from Production.Product as pp
inner join Production.ProductSubcategory as ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID;  --4ci


select pp.Name as Name, ps.Name as SubCategory, pc.Name as ProductCategory
from Production.Product as pp
inner join Production.ProductSubcategory as ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
inner join Production.ProductCategory as pc
on ps.ProductCategoryID = pc.ProductCategoryID; --4cii


select Color, MAX(ListPrice) as MaxListPrice
from Production.Product
group by Color;  --4di


select AVG(pp.ListPrice) as AVGListPrice, pc.Name as ProductCategory, ps.Name as ProductSubCategory
from Production.Product as pp
inner join Production.ProductSubcategory as ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
inner join Production.ProductCategory as pc
on ps.ProductCategoryID = pc.ProductCategoryID
group by pc.Name, ps.Name; --4dii



select COUNT(pp.Name) as AmountAvaibleProd, pc.Name as ProductCategory, ps.Name as ProductSubCategory
from Production.Product as pp
inner join Production.ProductSubcategory as ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
inner join Production.ProductCategory as pc
on ps.ProductCategoryID = pc.ProductCategoryID
group by pc.Name, ps.Name; --4diii



select AVG(pp.ListPrice) as ListPriceAVG, ps.Name
from Production.Product as pp 
inner join Production.ProductSubcategory as ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
group by ps.Name
having AVG(pp.ListPrice) > 100;  --4ei
