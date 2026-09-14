USE PProject;
GO
Select *
From PProject.dbo.NashHousing



-- Standardize Date Format


Select saleDate, CONVERT(Date,SaleDate)
From PProject.dbo.NashHousing


Update PProject.dbo.NashHousing
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE NashHousing
Add SaleDateConverted Date;
GO
Update NashHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)




-- Populate Property Address data

Select *
From PProject.dbo.NashHousing
--Where PropertyAddress is null
order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PProject.dbo.NashHousing a
JOIN PProject.dbo.NashHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PProject.dbo.NashHousing a
JOIN PProject.dbo.NashHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null






-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From PProject.dbo.NashHousing
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From PProject.dbo.NashHousing


ALTER TABLE NashHousing
Add PropertySplitAddress Nvarchar(255);
GO

Update NashHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashHousing
Add PropertySplitCity Nvarchar(255);
GO
Update NashHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




Select *
From PProject.dbo.NashHousing





Select OwnerAddress
From PProject.dbo.NashHousing


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PProject.dbo.NashHousing



ALTER TABLE NashHousing
Add OwnerSplitAddress Nvarchar(255);
GO
Update NashHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashHousing
Add OwnerSplitCity Nvarchar(255);
GO
Update NashHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashHousing
Add OwnerSplitState Nvarchar(255);
GO
Update NashHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From PProject.dbo.NashHousing







-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PProject.dbo.NashHousing
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PProject.dbo.NashHousing


Update NashHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END;


-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PProject.dbo.NashHousing
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



Select *
From PProject.dbo.NashHousing


-- Delete Unused Columns


Select *
From PProject.dbo.NashHousing


ALTER TABLE PProject.dbo.NashHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

SELECT * FROM PProject.dbo.NashHousing






















