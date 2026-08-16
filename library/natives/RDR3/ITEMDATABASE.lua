---@meta

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x856FF92C57742AE5)  
---This native does not have an official description.
---@param key Hash | string
---@param category Hash | string
---@param slotId Hash | string
---@return boolean
function ItemdatabaseCanEquipItemOnCategory(key, category, slotId) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x71EFA7999AE79408)  
---Returns collectionId to be used with 0x8750F69A720C2E41 (p0) and 0xCBB7B6EDFA933ADE (p0)
---@param comparisonType integer
---@return integer, any data, integer size
function ItemdatabaseCreateItemCollection(comparisonType) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x99C6EA66DFE73757)  
---Params: tag = TAG_ITEM_PROPERTY (tagType(?))
---@param bundle Hash | string
---@param tag Hash | string
---@param tagType Hash | string
---@return boolean
function ItemdatabaseDoesBundleHaveTag(bundle, tag, tagType) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xFF5FB5605AD56856)  
---This native does not have an official description.
---@param item Hash | string
---@param tag Hash | string
---@param tagType Hash | string
---@return boolean
function ItemdatabaseDoesItemHaveTag(item, tag, tagType) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x74F7928816E4E181)  
---This native does not have an official description.
---@param key Hash | string
---@param costtype Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutAcquireCost(key, costtype) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF27F01BBF5ACD3F3)  
---This native does not have an official description.
---@param award Hash | string
---@param costtype Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseFilloutAwardAcquireCost(award, costtype, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x121D2005DD64496B)  
---This native does not have an official description.
---@param award Hash | string
---@param index integer
---@return boolean, Hash outData
function ItemdatabaseFilloutAwardItemInfo(award, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x8D029948CA29409B)  
---This native does not have an official description.
---@param award Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseFilloutAwardUnlockFlag(award, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xB542632693D53408)  
---This native does not have an official description.
---@param bundle Hash | string
---@param cost Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseFilloutBundle(bundle, cost, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x74C3B1093728D263)  
---This native does not have an official description.
---@param bundle Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutBundleUiData(bundle) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xB52E20F6767A09A2)  
---This native does not have an official description.
---@param award Hash | string
---@param p3 integer
---@return boolean, any outData, integer outUnk
function ItemdatabaseFilloutBuyAwardAcquireCosts(award, p3) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF8D09EF8CE61D7BF)  
---This native does not have an official description.
---@param award Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutBuyAwardUiData(award) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xAD73B614DF26CF8A)  
---This native does not have an official description.
---@param key Hash | string
---@param costtype Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseFilloutItem(key, costtype, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x2A610BEE7D341CC4)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutItemByName(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCF2D360D27FD1ABF)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutItemEffectIdInfo(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9379BE60DC55BBE6)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutItemEffectIds(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xFE90ABBCBFDC13B2)  
---outputs struct ItemInfo { Hash category; Hash itemType; Hash unk2; Hash model; Hash award; }
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutItemInfo(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x60614A0AB580A2B5)  
---This native does not have an official description.
---@param key Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseFilloutModifier(key, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x40C5D95818823C94)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutPriceModifierByKey(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4776EFD78F75C23F)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean, integer outSatchelItemSize
function ItemdatabaseFilloutSatchelData(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x7A62A2EEDE1C3766)  
---Params: sellType = SELL_SHOP_DEFAULT
---@param key Hash | string
---@param sellType Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutSellPrice(key, sellType) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x5A11D6EEA17165B0)  
---This native does not have an official description.
---@param key Hash | string
---@param p3 integer
---@return boolean, any outData, integer outIndex
function ItemdatabaseFilloutTagData(key, p3) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xB86F7CC2DC67AC60)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseFilloutUiData(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6772A83C67A25775)  
---This native does not have an official description.
---@param key Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetAcquireCost(key, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x01FDDAD392D04144)  
---Returns the number of <Item>s <acquirecosts> has from the key in catalog_sp.ymt
---@param key Hash | string
---@return integer
function ItemdatabaseGetAcquireCostsCount(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xDEE7B3C76ED664BE)  
---This native does not have an official description.
---@param key Hash | string
---@param costtype Hash | string
---@return integer
function ItemdatabaseGetAcquireCostsCountFromCostType(key, costtype) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x1FC25AEB5F76B38D)  
---This native does not have an official description.
---@param award Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetAwardAcquireCost(award, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x12DF9C58201DD19A)  
---This native does not have an official description.
---@param key Hash | string
---@return integer
function ItemdatabaseGetAwardAcquireCostCount(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF540239F9937033B)  
---This native does not have an official description.
---@param award Hash | string
---@param costtype Hash | string
---@return integer
function ItemdatabaseGetAwardAcquireCostCountFromCostType(award, costtype) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xE81D0378A384E755)  
---This native does not have an official description.
---@param award Hash | string
---@return boolean, any outData
function ItemdatabaseGetAwardCostModifiers(award) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xD076DB9B96FAADF1)  
---This native does not have an official description.
---@param award Hash | string
---@return boolean, any outPageKey
function ItemdatabaseGetAwardInfo(award) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3FAA928A79591761)  
---Returns iAwardItemCount
---@param award Hash | string
---@return integer
function ItemdatabaseGetAwardItemCount(award) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x48229CE0C7938237)  
---hash eg: AWARD_DEBUG_HIDE_LEGENDARY_BOUNTY_00
---@param award Hash | string
---@return integer
function ItemdatabaseGetAwardUnlockFlagCount(award) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3A0B667ABFF87F6E)  
---eg: BUNDLE_CLOTHING_ITEM_F_OFFHAND_000_TINT_001 index: To use with 0x7A35A72A692BE9DB
---@param bundle Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetBundleAcquireCost(bundle, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xA97EE5E4589FCF5A)  
---This native does not have an official description.
---@param bundle Hash | string
---@return boolean, any outData
function ItemdatabaseGetBundleAcquireCostModifiers(bundle) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x7A35A72A692BE9DB)  
---eg: BUNDLE_CLOTHING_ITEM_F_OFFHAND_000_TINT_001
---@param bundle Hash | string
---@return integer
function ItemdatabaseGetBundleAcquireCostsCount(bundle) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x388088BFF3681189)  
---Return the number of currencies available for a bundle. To use with _ITEMDATABASE_FILLOUT_BUNDLE
---bundle: Hash — e.g: BUNDLE_CLOTHING_ITEM_F_OFFHAND_000_TINT_001
---cost: Hash — e.g: COST_GOLD, COST_CRAFTING_MP...
---@param bundle Hash | string
---@param cost Hash | string
---@return integer
function ItemdatabaseGetBundleAcquireCostsCountFromCost(bundle, cost) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x891A45960B6B768A)  
---This native does not have an official description.
---@param bundle Hash | string
---@return integer
function ItemdatabaseGetBundleId(bundle) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3332695B01015DF9)  
---This native does not have an official description.
---@param bundleId integer
---@return integer, any data
function ItemdatabaseGetBundleItemCount(bundleId) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x5D48A77E4B668B57)  
---This native does not have an official description.
---@param bundleId integer
---@param index integer
---@return boolean, any data, Hash outBundle
function ItemdatabaseGetBundleItemInfo(bundleId, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xAA29A5F13B2C20B2)  
---Returns Pathset Hash catalogItemCategory: Hash — e.g: CI_CATEGORY_AMMO, CI_CATEGORY_CAMP_TENT...
---Default: Hash — Always DEFAULT in R* scripts.
---@param catalogItemCategory Hash | string
---@param p1 Hash | string
---@return Hash
function ItemdatabaseGetCatalogItemCategoryPathset(catalogItemCategory, p1) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xD389A2549C4EFB30)  
---Returns (collection?) size/index (?)
---_ITEMDATABASE_GET_(A)* - _ITEMDATABASE_GET_(B)*
---@param collectionId integer
---@return integer
function ItemdatabaseGetCollectionSize(collectionId) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x8750F69A720C2E41)  
---Params: p2 can be a component item hash
---@param collectionId integer
---@param index integer
---@return boolean, Hash outKey
function ItemdatabaseGetComponentItem(collectionId, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x2970D1D6BFCF9B46)  
---This native does not have an official description.
---@param category Hash | string
---@return integer
function ItemdatabaseGetFitsSlotCount(category) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x77210C146CED5261)  
---This native does not have an official description.
---@param category Hash | string
---@param index integer
---@return boolean, Hash outSlotId
function ItemdatabaseGetFitsSlotInfo(category, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x44915068579D7710)  
---This native does not have an official description.
---@param category Hash | string
---@return integer
function ItemdatabaseGetHasSlotCount(category) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x8A9BD0DB7E8376CF)  
---This native does not have an official description.
---@param category Hash | string
---@param index integer
---@return boolean, Hash outSlotId
function ItemdatabaseGetHasSlotInfo(category, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF4452CE83118C738)  
---This native does not have an official description.
---@param key Hash | string
---@param defaultPathset Hash | string
---@return integer
function ItemdatabaseGetItemPathset(key, defaultPathset) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4EB37AAB79AB0C48)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseGetItemPriceModifiers(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x8870895BA5ED9385)  
---Returns the ci tags of the selected item tag
---key: Hash — Wanted key (e.g WEAPON_RIFLE_VARMINT).tag: Hash — The item tag (e.g TAG_ITEM_PROPERTY).data: Any* - CI tag list starting at the offset "1", the offset 0 is to define the max number of tags you want to collect (uselly 5 in R* scripts, surelly the limit)
---@param key Hash | string
---@param tagType Hash | string
---@return integer, any outData
function ItemdatabaseGetItemTagTags(key, tagType) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6111B8F9413F413A)  
---This native does not have an official description.
---@param item Hash | string
---@param tag Hash | string
---@return Hash
function ItemdatabaseGetItemTagType(item, tag) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCB92EC9C004732B4)  
---Returns an alternative cost hash to COST_SHOP_DEFAULT
---@param key Hash | string
---@param index integer
---@return Hash
function ItemdatabaseGetModifiedPrice(key, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x5AAAF40E9B224F5E)  
---This native does not have an official description.
---@param key Hash | string
---@return integer
function ItemdatabaseGetNumberOfModifiedPrices(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x1289D8315235856D)  
---This native does not have an official description.
---@param key Hash | string
---@return integer
function ItemdatabaseGetNumberOfModifiers(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xEF254F1A4C08B7E6)  
---_ITEMDATABASE_GET_* - _ITEMDATABASE_IS_*
---@param award Hash | string
---@return boolean
function ItemdatabaseGetPriorityAccessAward(award) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4A79B41B4EB91F4E)  
---This native does not have an official description.
---@param shopType Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetShopInventoriesItemInfo(shopType, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCFB06801F5099B25)  
---Same Native Function as 0x17721003A66C72BF
---@param shopType Hash | string
---@param key Hash | string
---@return boolean, any outData
function ItemdatabaseGetShopInventoriesItemInfoByKey(shopType, key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xC568B1A0F17C7025)  
---This native does not have an official description.
---@param shopType Hash | string
---@return integer
function ItemdatabaseGetShopInventoriesItemsCount(shopType) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x76C752D788A76813)  
---This native does not have an official description.
---@param shopType Hash | string
---@param key Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetShopInventoriesRequirementGroupInfo(shopType, key, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xE0EA5C031AE5539F)  
---This native does not have an official description.
---@param shopType Hash | string
---@param key Hash | string
---@param groupIndex integer
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetShopInventoriesRequirementInfo(shopType, key, groupIndex, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x66A6D76B6BB999B4)  
---This native does not have an official description.
---@param layout Hash | string
---@return boolean, any outData
function ItemdatabaseGetShopLayoutInfo(layout) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xD66114469978B55B)  
---This native does not have an official description.
---@param layout Hash | string
---@param menu Hash | string
---@return boolean, any outData
function ItemdatabaseGetShopLayoutMenuInfoById(layout, menu) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF04247092F193B75)  
---This native does not have an official description.
---@param layout Hash | string
---@param menu Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetShopLayoutMenuInfoByIndex(layout, menu, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9A60570657A7B635)  
---This native does not have an official description.
---@param layout Hash | string
---@param menu Hash | string
---@param index integer
---@return boolean, Hash outPageKey
function ItemdatabaseGetShopLayoutMenuPageKey(layout, menu, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xDBEADA0DF5F9AB9F)  
---Returns the layout page info at the selected index
---@param layout Hash | string
---@param index integer
---@return boolean, integer outPageKey
function ItemdatabaseGetShopLayoutPageInfoByIndex(layout, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xB347C100DF0C9B7F)  
---This native does not have an official description.
---@param layout Hash | string
---@param pageKey Hash | string
---@return boolean, any outData
function ItemdatabaseGetShopLayoutPageInfoByKey(layout, pageKey) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF32BEF578B3DBAE8)  
---This native does not have an official description.
---@param layout Hash | string
---@param pageKey Hash | string
---@param index integer
---@return boolean, Hash outItemKey, integer outMenuId, Hash outLayout
function ItemdatabaseGetShopLayoutPageItemKey(layout, pageKey, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x86FCB565CCA0CFA7)  
---This native does not have an official description.
---@param layout Hash | string
---@param index integer
---@return boolean, any outData
function ItemdatabaseGetShopLayoutRootMenuInfo(layout, index) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4308812A6E9CA62E)  
---Params: mode is 0
---@param bundle Hash | string
---@param mode integer
---@return boolean
function ItemdatabaseIsBundleValid(bundle, mode) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4CE753203FA42214)  
---This native does not have an official description.
---@param award Hash | string
---@return boolean
function ItemdatabaseIsBuyableAwardValid(award) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x337F88E3A063995E)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean
function ItemdatabaseIsIntrinsicItem(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6D5D51B188333FD1)  
---Params: mode is 0
---@param key Hash | string
---@param mode integer
---@return boolean
function ItemdatabaseIsKeyValid(key, mode) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x337F88E3A063995F)  
---This native does not have an official description.
---@param key Hash | string
---@return boolean
function ItemdatabaseIsOverpoweredItem(key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x00B9507D8E1D8716)  
---This native does not have an official description.
---@param shopType Hash | string
---@return boolean
function ItemdatabaseIsShopKeyValid(shopType) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3AFE5182C45A84F6)  
---This native does not have an official description.
---@param layout Hash | string
---@return boolean
function ItemdatabaseIsShopLayoutKeyValid(layout) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCEC6A41E8910486A)  
---Returns docData.iNumTotalLabelTypes
---@param p0 any
---@return integer
function ItemdatabaseLocalizationGetNumLabelTypes(p0) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x49885D82A13EEAEA)  
---Returns iNumValuesForType
---@param p0 any
---@param p1 any
---@return integer
function ItemdatabaseLocalizationGetNumValues(p0, p1) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCABF5D41D0073D4A)  
---Returns LabelType
---@param p0 any
---@param p1 any
---@return any
function ItemdatabaseLocalizationGetType(p0, p1) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9AE5610FDCED6EA7)  
---This native does not have an official description.
---@param p0 any
---@param label Hash | string
---@param p2 any
---@return integer
function ItemdatabaseLocalizationGetValue(p0, label, p2) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCBB7B6EDFA933ADE)  
---This native does not have an official description.
---@param collectionId integer
---@return boolean
function ItemdatabaseReleaseItemCollection(collectionId) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x17721003A66C72BF)  
---This native does not have an official description.
---@param shopType Hash | string
---@param key Hash | string
---@return boolean, any outData
function N_0x17721003a66c72bf(shopType, key) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x537A0555F62CA01A)  
---This native does not have an official description.
---@param key Hash | string
---@param p1 integer
---@return boolean
function N_0x537a0555f62ca01a(key, p1) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x799FCD53358ED5FA)  
---Returns Item Count
---@param bundle any
---@param p1 any
---@return integer
function N_0x799fcd53358ed5fa(bundle, p1) end

---**`ITEMDATABASE` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xC4146375D8A0B374)  
---This native does not have an official description.
---@param bundle any
---@param p1 any
---@param index integer
---@param p3 any
---@return boolean
function N_0xc4146375d8a0b374(bundle, p1, index, p3) end

