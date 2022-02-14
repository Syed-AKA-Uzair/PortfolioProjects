--Cleaning Data in SQL

Select * from PortfolioProject.dbo.NashvilleHousing

--Standardize Date Format

Select SaleDateNew, Convert(Date, SaleDate) from PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER Table NashvilleHousing
ADD SaleDateNew Date;
Update NashvilleHousing
SET SaleDateNEW = CONVERT(Date, SaleDate)

--Populate Property Address Data

Select * from PortfolioProject.dbo.NashvilleHousing
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b 
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
	Where a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b 
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
	Where a.PropertyAddress is null

--Breaking out ADDRESS into individual columns (Address, City, State)
Select PropertyAddress from PortfolioProject.dbo.NashvilleHousing

Select SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as City
from PortfolioProject.dbo.NashvilleHousing

--Adding Split address column
ALTER Table NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);
Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

--Adding Split City column
ALTER Table NashvilleHousing
ADD PropertySplitCity Nvarchar(255);
Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) 

Select * from PortfolioProject.dbo.NashvilleHousing

--Using ParseName
Select PARSENAME(Replace(OwnerAddress, ',', '.'),3) as Address,
PARSENAME(Replace(OwnerAddress, ',', '.'),2) as City,
PARSENAME(Replace(OwnerAddress, ',', '.'),1) as State 
from PortfolioProject.dbo.NashvilleHousing

ALTER Table NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);
Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'),3)

ALTER Table NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);
Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'),2)

ALTER Table NashvilleHousing
ADD OwnerSplitState Nvarchar(255);
Update NashvilleHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'),1)

--Change Y and N to YES and No in 'Sold as Vacant' Field

Select Distinct(SoldAsVacant),Count(SoldAsVacant) 
from PortfolioProject.dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant,
CASE When SoldAsVacant = 'Y' Then 'Yes'
	When SoldAsVacant = 'N' Then 'No'
	Else SoldAsVacant
	END
from PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
						When SoldAsVacant = 'N' Then 'No'
						Else SoldAsVacant
						END	

--Remove Duplicates using CTE & RowNum

WITH RowNumCTE AS(
	Select * , 
		ROW_NUMBER() OVER(
		Partition by ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER BY
						UniqueID) row_num
 from PortfolioProject.dbo.NashvilleHousing
 )
 Select * from RowNumCTE
 Where row_num > 1
 Order By PropertyAddress

 WITH RowNumCTE AS(
	Select * , 
		ROW_NUMBER() OVER(
		Partition by ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER BY
						UniqueID) row_num
 from PortfolioProject.dbo.NashvilleHousing
 )
 DELETE from RowNumCTE
 Where row_num > 1
 

 --Delete Unused Columns

Select * from PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP Column PropertyAddress,OwnerAddress, TaxDistrict