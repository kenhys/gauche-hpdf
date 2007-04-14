;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

;; The following is a dummy test code.
;; Replace it for your tests.
(test* "hpdf-getversion" "2.0.8" (hpdf-getversion))

;; Test Constant
(test* "HPDF_TRUE" 1 HPDF_TRUE)
(test* "HPDF_FALSE" 0 HPDF_FALSE)
(test* "HPDF_OK" 0 HPDF_OK)
(test* "HPDF_NOERROR" 0 HPDF_NOERROR)

(test* "HPDF_VERSION_TEXT" "2.0.8" HPDF_VERSION_TEXT)

;; country code definition
(test* "HPDF_COUNTRY_AF" "AF" HPDF_COUNTRY_AF) ;; AFGHANISTAN
(test* "HPDF_COUNTRY_AL" "AL" HPDF_COUNTRY_AL) ;; ALBANIA
(test* "HPDF_COUNTRY_DZ" "DZ" HPDF_COUNTRY_DZ) ;; ALGERIA
(test* "HPDF_COUNTRY_AS" "AS" HPDF_COUNTRY_AS) ;; AMERICAN SAMOA
(test* "HPDF_COUNTRY_AD" "AD" HPDF_COUNTRY_AD) ;; ANDORRA
(test* "HPDF_COUNTRY_AO" "AO" HPDF_COUNTRY_AO) ;; ANGOLA
(test* "HPDF_COUNTRY_AI" "AI" HPDF_COUNTRY_AI) ;; ANGUILLA
(test* "HPDF_COUNTRY_AQ" "AQ" HPDF_COUNTRY_AQ) ;; ANTARCTICA
(test* "HPDF_COUNTRY_AG" "AG" HPDF_COUNTRY_AG) ;; ANTIGUA AND BARBUDA
(test* "HPDF_COUNTRY_AR" "AR" HPDF_COUNTRY_AR) ;; ARGENTINA
(test* "HPDF_COUNTRY_AM" "AM" HPDF_COUNTRY_AM) ;; ARMENIA
(test* "HPDF_COUNTRY_AW" "AW" HPDF_COUNTRY_AW) ;; ARUBA
(test* "HPDF_COUNTRY_AU" "AU" HPDF_COUNTRY_AU) ;; AUSTRALIA
(test* "HPDF_COUNTRY_AT" "AT" HPDF_COUNTRY_AT) ;; AUSTRIA
(test* "HPDF_COUNTRY_AZ" "AZ" HPDF_COUNTRY_AZ) ;; AZERBAIJAN
(test* "HPDF_COUNTRY_BS" "BS" HPDF_COUNTRY_BS) ;; BAHAMAS
(test* "HPDF_COUNTRY_BH" "BH" HPDF_COUNTRY_BH) ;; BAHRAIN
(test* "HPDF_COUNTRY_BD" "BD" HPDF_COUNTRY_BD) ;; BANGLADESH
(test* "HPDF_COUNTRY_BB" "BB" HPDF_COUNTRY_BB) ;; BARBADOS
(test* "HPDF_COUNTRY_BY" "BY" HPDF_COUNTRY_BY) ;; BELARUS
(test* "HPDF_COUNTRY_BE" "BE" HPDF_COUNTRY_BE) ;; BELGIUM
(test* "HPDF_COUNTRY_BZ" "BZ" HPDF_COUNTRY_BZ) ;; BELIZE
(test* "HPDF_COUNTRY_BJ" "BJ" HPDF_COUNTRY_BJ) ;; BENIN
(test* "HPDF_COUNTRY_BM" "BM" HPDF_COUNTRY_BM) ;; BERMUDA
(test* "HPDF_COUNTRY_BT" "BT" HPDF_COUNTRY_BT) ;; BHUTAN
(test* "HPDF_COUNTRY_BO" "BO" HPDF_COUNTRY_BO) ;; BOLIVIA
(test* "HPDF_COUNTRY_BA" "BA" HPDF_COUNTRY_BA) ;; BOSNIA AND HERZEGOWINA
(test* "HPDF_COUNTRY_BW" "BW" HPDF_COUNTRY_BW) ;; BOTSWANA
(test* "HPDF_COUNTRY_BV" "BV" HPDF_COUNTRY_BV) ;; BOUVET ISLAND
(test* "HPDF_COUNTRY_BR" "BR" HPDF_COUNTRY_BR) ;; BRAZIL
(test* "HPDF_COUNTRY_IO" "IO" HPDF_COUNTRY_IO) ;; BRITISH INDIAN OCEAN TERRITORY
(test* "HPDF_COUNTRY_BN" "BN" HPDF_COUNTRY_BN) ;; BRUNEI DARUSSALAM
(test* "HPDF_COUNTRY_BG" "BG" HPDF_COUNTRY_BG) ;; BULGARIA
(test* "HPDF_COUNTRY_BF" "BF" HPDF_COUNTRY_BF) ;; BURKINA FASO
(test* "HPDF_COUNTRY_BI" "BI" HPDF_COUNTRY_BI) ;; BURUNDI
(test* "HPDF_COUNTRY_KH" "KH" HPDF_COUNTRY_KH) ;; CAMBODIA
(test* "HPDF_COUNTRY_CM" "CM" HPDF_COUNTRY_CM) ;; CAMEROON
(test* "HPDF_COUNTRY_CA" "CA" HPDF_COUNTRY_CA) ;; CANADA
(test* "HPDF_COUNTRY_CV" "CV" HPDF_COUNTRY_CV) ;; CAPE VERDE
(test* "HPDF_COUNTRY_KY" "KY" HPDF_COUNTRY_KY) ;; CAYMAN ISLANDS
(test* "HPDF_COUNTRY_CF" "CF" HPDF_COUNTRY_CF) ;; CENTRAL AFRICAN REPUBLIC
(test* "HPDF_COUNTRY_TD" "TD" HPDF_COUNTRY_TD) ;; CHAD
(test* "HPDF_COUNTRY_CL" "CL" HPDF_COUNTRY_CL) ;; CHILE
(test* "HPDF_COUNTRY_CN" "CN" HPDF_COUNTRY_CN) ;; CHINA
(test* "HPDF_COUNTRY_CX" "CX" HPDF_COUNTRY_CX) ;; CHRISTMAS ISLAND
(test* "HPDF_COUNTRY_CC" "CC" HPDF_COUNTRY_CC) ;; COCOS (KEELING) ISLANDS
(test* "HPDF_COUNTRY_CO" "CO" HPDF_COUNTRY_CO) ;; COLOMBIA
(test* "HPDF_COUNTRY_KM" "KM" HPDF_COUNTRY_KM) ;; COMOROS
(test* "HPDF_COUNTRY_CG" "CG" HPDF_COUNTRY_CG) ;; CONGO
(test* "HPDF_COUNTRY_CK" "CK" HPDF_COUNTRY_CK) ;; COOK ISLANDS
(test* "HPDF_COUNTRY_CR" "CR" HPDF_COUNTRY_CR) ;; COSTA RICA
(test* "HPDF_COUNTRY_CI" "CI" HPDF_COUNTRY_CI) ;; COTE D'IVOIRE
(test* "HPDF_COUNTRY_HR" "HR" HPDF_COUNTRY_HR) ;; CROATIA (local name: Hrvatska)
(test* "HPDF_COUNTRY_CU" "CU" HPDF_COUNTRY_CU) ;; CUBA
(test* "HPDF_COUNTRY_CY" "CY" HPDF_COUNTRY_CY) ;; CYPRUS
(test* "HPDF_COUNTRY_CZ" "CZ" HPDF_COUNTRY_CZ) ;; CZECH REPUBLIC
(test* "HPDF_COUNTRY_DK" "DK" HPDF_COUNTRY_DK) ;; DENMARK
(test* "HPDF_COUNTRY_DJ" "DJ" HPDF_COUNTRY_DJ) ;; DJIBOUTI
(test* "HPDF_COUNTRY_DM" "DM" HPDF_COUNTRY_DM) ;; DOMINICA
(test* "HPDF_COUNTRY_DO" "DO" HPDF_COUNTRY_DO) ;; DOMINICAN REPUBLIC
(test* "HPDF_COUNTRY_TP" "TP" HPDF_COUNTRY_TP) ;; EAST TIMOR
(test* "HPDF_COUNTRY_EC" "EC" HPDF_COUNTRY_EC) ;; ECUADOR
(test* "HPDF_COUNTRY_EG" "EG" HPDF_COUNTRY_EG) ;; EGYPT
(test* "HPDF_COUNTRY_SV" "SV" HPDF_COUNTRY_SV) ;; EL SALVADOR
(test* "HPDF_COUNTRY_GQ" "GQ" HPDF_COUNTRY_GQ) ;; EQUATORIAL GUINEA
(test* "HPDF_COUNTRY_ER" "ER" HPDF_COUNTRY_ER) ;; ERITREA
(test* "HPDF_COUNTRY_EE" "EE" HPDF_COUNTRY_EE) ;; ESTONIA
(test* "HPDF_COUNTRY_ET" "ET" HPDF_COUNTRY_ET) ;; ETHIOPIA
(test* "HPDF_COUNTRY_FK" "FK" HPDF_COUNTRY_FK) ;; FALKLAND ISLANDS (MALVINAS)
(test* "HPDF_COUNTRY_FO" "FO" HPDF_COUNTRY_FO) ;; FAROE ISLANDS
(test* "HPDF_COUNTRY_FJ" "FJ" HPDF_COUNTRY_FJ) ;; FIJI
(test* "HPDF_COUNTRY_FI" "FI" HPDF_COUNTRY_FI) ;; FINLAND
(test* "HPDF_COUNTRY_FR" "FR" HPDF_COUNTRY_FR) ;; FRANCE
(test* "HPDF_COUNTRY_FX" "FX" HPDF_COUNTRY_FX) ;; FRANCE, METROPOLITAN
(test* "HPDF_COUNTRY_GF" "GF" HPDF_COUNTRY_GF) ;; FRENCH GUIANA
(test* "HPDF_COUNTRY_PF" "PF" HPDF_COUNTRY_PF) ;; FRENCH POLYNESIA
(test* "HPDF_COUNTRY_TF" "TF" HPDF_COUNTRY_TF) ;; FRENCH SOUTHERN TERRITORIES
(test* "HPDF_COUNTRY_GA" "GA" HPDF_COUNTRY_GA) ;; GABON
(test* "HPDF_COUNTRY_GM" "GM" HPDF_COUNTRY_GM) ;; GAMBIA
(test* "HPDF_COUNTRY_GE" "GE" HPDF_COUNTRY_GE) ;; GEORGIA
(test* "HPDF_COUNTRY_DE" "DE" HPDF_COUNTRY_DE) ;; GERMANY
(test* "HPDF_COUNTRY_GH" "GH" HPDF_COUNTRY_GH) ;; GHANA
(test* "HPDF_COUNTRY_GI" "GI" HPDF_COUNTRY_GI) ;; GIBRALTAR
(test* "HPDF_COUNTRY_GR" "GR" HPDF_COUNTRY_GR) ;; GREECE
(test* "HPDF_COUNTRY_GL" "GL" HPDF_COUNTRY_GL) ;; GREENLAND
(test* "HPDF_COUNTRY_GD" "GD" HPDF_COUNTRY_GD) ;; GRENADA
(test* "HPDF_COUNTRY_GP" "GP" HPDF_COUNTRY_GP) ;; GUADELOUPE
(test* "HPDF_COUNTRY_GU" "GU" HPDF_COUNTRY_GU) ;; GUAM
(test* "HPDF_COUNTRY_GT" "GT" HPDF_COUNTRY_GT) ;; GUATEMALA
(test* "HPDF_COUNTRY_GN" "GN" HPDF_COUNTRY_GN) ;; GUINEA
(test* "HPDF_COUNTRY_GW" "GW" HPDF_COUNTRY_GW) ;; GUINEA-BISSAU
(test* "HPDF_COUNTRY_GY" "GY" HPDF_COUNTRY_GY) ;; GUYANA
(test* "HPDF_COUNTRY_HT" "HT" HPDF_COUNTRY_HT) ;; HAITI
(test* "HPDF_COUNTRY_HM" "HM" HPDF_COUNTRY_HM) ;; HEARD AND MC DONALD ISLANDS
(test* "HPDF_COUNTRY_HN" "HN" HPDF_COUNTRY_HN) ;; HONDURAS
(test* "HPDF_COUNTRY_HK" "HK" HPDF_COUNTRY_HK) ;; HONG KONG
(test* "HPDF_COUNTRY_HU" "HU" HPDF_COUNTRY_HU) ;; HUNGARY
(test* "HPDF_COUNTRY_IS" "IS" HPDF_COUNTRY_IS) ;; ICELAND
(test* "HPDF_COUNTRY_IN" "IN" HPDF_COUNTRY_IN) ;; INDIA
(test* "HPDF_COUNTRY_ID" "ID" HPDF_COUNTRY_ID) ;; INDONESIA
(test* "HPDF_COUNTRY_IR" "IR" HPDF_COUNTRY_IR) ;; IRAN (ISLAMIC REPUBLIC OF)
(test* "HPDF_COUNTRY_IQ" "IQ" HPDF_COUNTRY_IQ) ;; IRAQ
(test* "HPDF_COUNTRY_IE" "IE" HPDF_COUNTRY_IE) ;; IRELAND
(test* "HPDF_COUNTRY_IL" "IL" HPDF_COUNTRY_IL) ;; ISRAEL
(test* "HPDF_COUNTRY_IT" "IT" HPDF_COUNTRY_IT) ;; ITALY
(test* "HPDF_COUNTRY_JM" "JM" HPDF_COUNTRY_JM) ;; JAMAICA
(test* "HPDF_COUNTRY_JP" "JP" HPDF_COUNTRY_JP) ;; JAPAN
(test* "HPDF_COUNTRY_JO" "JO" HPDF_COUNTRY_JO) ;; JORDAN
(test* "HPDF_COUNTRY_KZ" "KZ" HPDF_COUNTRY_KZ) ;; KAZAKHSTAN
(test* "HPDF_COUNTRY_KE" "KE" HPDF_COUNTRY_KE) ;; KENYA
(test* "HPDF_COUNTRY_KI" "KI" HPDF_COUNTRY_KI) ;; KIRIBATI
(test* "HPDF_COUNTRY_KP" "KP" HPDF_COUNTRY_KP) ;; KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF
(test* "HPDF_COUNTRY_KR" "KR" HPDF_COUNTRY_KR) ;; KOREA, REPUBLIC OF
(test* "HPDF_COUNTRY_KW" "KW" HPDF_COUNTRY_KW) ;; KUWAIT
(test* "HPDF_COUNTRY_KG" "KG" HPDF_COUNTRY_KG) ;; KYRGYZSTAN
(test* "HPDF_COUNTRY_LA" "LA" HPDF_COUNTRY_LA) ;; LAO PEOPLE'S DEMOCRATIC REPUBLIC
(test* "HPDF_COUNTRY_LV" "LV" HPDF_COUNTRY_LV) ;; LATVIA
(test* "HPDF_COUNTRY_LB" "LB" HPDF_COUNTRY_LB) ;; LEBANON
(test* "HPDF_COUNTRY_LS" "LS" HPDF_COUNTRY_LS) ;; LESOTHO
(test* "HPDF_COUNTRY_LR" "LR" HPDF_COUNTRY_LR) ;; LIBERIA
(test* "HPDF_COUNTRY_LY" "LY" HPDF_COUNTRY_LY) ;; LIBYAN ARAB JAMAHIRIYA
(test* "HPDF_COUNTRY_LI" "LI" HPDF_COUNTRY_LI) ;; LIECHTENSTEIN
(test* "HPDF_COUNTRY_LT" "LT" HPDF_COUNTRY_LT) ;; LITHUANIA
(test* "HPDF_COUNTRY_LU" "LU" HPDF_COUNTRY_LU) ;; LUXEMBOURG
(test* "HPDF_COUNTRY_MO" "MO" HPDF_COUNTRY_MO) ;; MACAU
(test* "HPDF_COUNTRY_MK" "MK" HPDF_COUNTRY_MK) ;; MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF
(test* "HPDF_COUNTRY_MG" "MG" HPDF_COUNTRY_MG) ;; MADAGASCAR
(test* "HPDF_COUNTRY_MW" "MW" HPDF_COUNTRY_MW) ;; MALAWI
(test* "HPDF_COUNTRY_MY" "MY" HPDF_COUNTRY_MY) ;; MALAYSIA
(test* "HPDF_COUNTRY_MV" "MV" HPDF_COUNTRY_MV) ;; MALDIVES
(test* "HPDF_COUNTRY_ML" "ML" HPDF_COUNTRY_ML) ;; MALI
(test* "HPDF_COUNTRY_MT" "MT" HPDF_COUNTRY_MT) ;; MALTA
(test* "HPDF_COUNTRY_MH" "MH" HPDF_COUNTRY_MH) ;; MARSHALL ISLANDS
(test* "HPDF_COUNTRY_MQ" "MQ" HPDF_COUNTRY_MQ) ;; MARTINIQUE
(test* "HPDF_COUNTRY_MR" "MR" HPDF_COUNTRY_MR) ;; MAURITANIA
(test* "HPDF_COUNTRY_MU" "MU" HPDF_COUNTRY_MU) ;; MAURITIUS
(test* "HPDF_COUNTRY_YT" "YT" HPDF_COUNTRY_YT) ;; MAYOTTE
(test* "HPDF_COUNTRY_MX" "MX" HPDF_COUNTRY_MX) ;; MEXICO
(test* "HPDF_COUNTRY_FM" "FM" HPDF_COUNTRY_FM) ;; MICRONESIA, FEDERATED STATES OF
(test* "HPDF_COUNTRY_MD" "MD" HPDF_COUNTRY_MD) ;; MOLDOVA, REPUBLIC OF
(test* "HPDF_COUNTRY_MC" "MC" HPDF_COUNTRY_MC) ;; MONACO
(test* "HPDF_COUNTRY_MN" "MN" HPDF_COUNTRY_MN) ;; MONGOLIA
(test* "HPDF_COUNTRY_MS" "MS" HPDF_COUNTRY_MS) ;; MONTSERRAT
(test* "HPDF_COUNTRY_MA" "MA" HPDF_COUNTRY_MA) ;; MOROCCO
(test* "HPDF_COUNTRY_MZ" "MZ" HPDF_COUNTRY_MZ) ;; MOZAMBIQUE
(test* "HPDF_COUNTRY_MM" "MM" HPDF_COUNTRY_MM) ;; MYANMAR
(test* "HPDF_COUNTRY_NA" "NA" HPDF_COUNTRY_NA) ;; NAMIBIA
(test* "HPDF_COUNTRY_NR" "NR" HPDF_COUNTRY_NR) ;; NAURU
(test* "HPDF_COUNTRY_NP" "NP" HPDF_COUNTRY_NP) ;; NEPAL
(test* "HPDF_COUNTRY_NL" "NL" HPDF_COUNTRY_NL) ;; NETHERLANDS
(test* "HPDF_COUNTRY_AN" "AN" HPDF_COUNTRY_AN) ;; NETHERLANDS ANTILLES
(test* "HPDF_COUNTRY_NC" "NC" HPDF_COUNTRY_NC) ;; NEW CALEDONIA
(test* "HPDF_COUNTRY_NZ" "NZ" HPDF_COUNTRY_NZ) ;; NEW ZEALAND
(test* "HPDF_COUNTRY_NI" "NI" HPDF_COUNTRY_NI) ;; NICARAGUA
(test* "HPDF_COUNTRY_NE" "NE" HPDF_COUNTRY_NE) ;; NIGER
(test* "HPDF_COUNTRY_NG" "NG" HPDF_COUNTRY_NG) ;; NIGERIA
(test* "HPDF_COUNTRY_NU" "NU" HPDF_COUNTRY_NU) ;; NIUE
(test* "HPDF_COUNTRY_NF" "NF" HPDF_COUNTRY_NF) ;; NORFOLK ISLAND
(test* "HPDF_COUNTRY_MP" "MP" HPDF_COUNTRY_MP) ;; NORTHERN MARIANA ISLANDS
(test* "HPDF_COUNTRY_NO" "NO" HPDF_COUNTRY_NO) ;; NORWAY
(test* "HPDF_COUNTRY_OM" "OM" HPDF_COUNTRY_OM) ;; OMAN
(test* "HPDF_COUNTRY_PK" "PK" HPDF_COUNTRY_PK) ;; PAKISTAN
(test* "HPDF_COUNTRY_PW" "PW" HPDF_COUNTRY_PW) ;; PALAU
(test* "HPDF_COUNTRY_PA" "PA" HPDF_COUNTRY_PA) ;; PANAMA
(test* "HPDF_COUNTRY_PG" "PG" HPDF_COUNTRY_PG) ;; PAPUA NEW GUINEA
(test* "HPDF_COUNTRY_PY" "PY" HPDF_COUNTRY_PY) ;; PARAGUAY
(test* "HPDF_COUNTRY_PE" "PE" HPDF_COUNTRY_PE) ;; PERU
(test* "HPDF_COUNTRY_PH" "PH" HPDF_COUNTRY_PH) ;; PHILIPPINES
(test* "HPDF_COUNTRY_PN" "PN" HPDF_COUNTRY_PN) ;; PITCAIRN
(test* "HPDF_COUNTRY_PL" "PL" HPDF_COUNTRY_PL) ;; POLAND
(test* "HPDF_COUNTRY_PT" "PT" HPDF_COUNTRY_PT) ;; PORTUGAL
(test* "HPDF_COUNTRY_PR" "PR" HPDF_COUNTRY_PR) ;; PUERTO RICO
(test* "HPDF_COUNTRY_QA" "QA" HPDF_COUNTRY_QA) ;; QATAR
(test* "HPDF_COUNTRY_RE" "RE" HPDF_COUNTRY_RE) ;; REUNION
(test* "HPDF_COUNTRY_RO" "RO" HPDF_COUNTRY_RO) ;; ROMANIA
(test* "HPDF_COUNTRY_RU" "RU" HPDF_COUNTRY_RU) ;; RUSSIAN FEDERATION
(test* "HPDF_COUNTRY_RW" "RW" HPDF_COUNTRY_RW) ;; RWANDA
(test* "HPDF_COUNTRY_KN" "KN" HPDF_COUNTRY_KN) ;; SAINT KITTS AND NEVIS
(test* "HPDF_COUNTRY_LC" "LC" HPDF_COUNTRY_LC) ;; SAINT LUCIA
(test* "HPDF_COUNTRY_VC" "VC" HPDF_COUNTRY_VC) ;; SAINT VINCENT AND THE GRENADINES
(test* "HPDF_COUNTRY_WS" "WS" HPDF_COUNTRY_WS) ;; SAMOA
(test* "HPDF_COUNTRY_SM" "SM" HPDF_COUNTRY_SM) ;; SAN MARINO
(test* "HPDF_COUNTRY_ST" "ST" HPDF_COUNTRY_ST) ;; SAO TOME AND PRINCIPE
(test* "HPDF_COUNTRY_SA" "SA" HPDF_COUNTRY_SA) ;; SAUDI ARABIA
(test* "HPDF_COUNTRY_SN" "SN" HPDF_COUNTRY_SN) ;; SENEGAL
(test* "HPDF_COUNTRY_SC" "SC" HPDF_COUNTRY_SC) ;; SEYCHELLES
(test* "HPDF_COUNTRY_SL" "SL" HPDF_COUNTRY_SL) ;; SIERRA LEONE
(test* "HPDF_COUNTRY_SG" "SG" HPDF_COUNTRY_SG) ;; SINGAPORE
(test* "HPDF_COUNTRY_SK" "SK" HPDF_COUNTRY_SK) ;; SLOVAKIA (Slovak Republic)
(test* "HPDF_COUNTRY_SI" "SI" HPDF_COUNTRY_SI) ;; SLOVENIA
(test* "HPDF_COUNTRY_SB" "SB" HPDF_COUNTRY_SB) ;; SOLOMON ISLANDS
(test* "HPDF_COUNTRY_SO" "SO" HPDF_COUNTRY_SO) ;; SOMALIA
(test* "HPDF_COUNTRY_ZA" "ZA" HPDF_COUNTRY_ZA) ;; SOUTH AFRICA
(test* "HPDF_COUNTRY_ES" "ES" HPDF_COUNTRY_ES) ;; SPAIN
(test* "HPDF_COUNTRY_LK" "LK" HPDF_COUNTRY_LK) ;; SRI LANKA
(test* "HPDF_COUNTRY_SH" "SH" HPDF_COUNTRY_SH) ;; ST. HELENA
(test* "HPDF_COUNTRY_PM" "PM" HPDF_COUNTRY_PM) ;; ST. PIERRE AND MIQUELON
(test* "HPDF_COUNTRY_SD" "SD" HPDF_COUNTRY_SD) ;; SUDAN
(test* "HPDF_COUNTRY_SR" "SR" HPDF_COUNTRY_SR) ;; SURINAME
(test* "HPDF_COUNTRY_SJ" "SJ" HPDF_COUNTRY_SJ) ;; SVALBARD AND JAN MAYEN ISLANDS
(test* "HPDF_COUNTRY_SZ" "SZ" HPDF_COUNTRY_SZ) ;; SWAZILAND
(test* "HPDF_COUNTRY_SE" "SE" HPDF_COUNTRY_SE) ;; SWEDEN
(test* "HPDF_COUNTRY_CH" "CH" HPDF_COUNTRY_CH) ;; SWITZERLAND
(test* "HPDF_COUNTRY_SY" "SY" HPDF_COUNTRY_SY) ;; SYRIAN ARAB REPUBLIC
(test* "HPDF_COUNTRY_TW" "TW" HPDF_COUNTRY_TW) ;; TAIWAN, PROVINCE OF CHINA
(test* "HPDF_COUNTRY_TJ" "TJ" HPDF_COUNTRY_TJ) ;; TAJIKISTAN
(test* "HPDF_COUNTRY_TZ" "TZ" HPDF_COUNTRY_TZ) ;; TANZANIA, UNITED REPUBLIC OF
(test* "HPDF_COUNTRY_TH" "TH" HPDF_COUNTRY_TH) ;; THAILAND
(test* "HPDF_COUNTRY_TG" "TG" HPDF_COUNTRY_TG) ;; TOGO
(test* "HPDF_COUNTRY_TK" "TK" HPDF_COUNTRY_TK) ;; TOKELAU
(test* "HPDF_COUNTRY_TO" "TO" HPDF_COUNTRY_TO) ;; TONGA
(test* "HPDF_COUNTRY_TT" "TT" HPDF_COUNTRY_TT) ;; TRINIDAD AND TOBAGO
(test* "HPDF_COUNTRY_TN" "TN" HPDF_COUNTRY_TN) ;; TUNISIA
(test* "HPDF_COUNTRY_TR" "TR" HPDF_COUNTRY_TR) ;; TURKEY
(test* "HPDF_COUNTRY_TM" "TM" HPDF_COUNTRY_TM) ;; TURKMENISTAN
(test* "HPDF_COUNTRY_TC" "TC" HPDF_COUNTRY_TC) ;; TURKS AND CAICOS ISLANDS
(test* "HPDF_COUNTRY_TV" "TV" HPDF_COUNTRY_TV) ;; TUVALU
(test* "HPDF_COUNTRY_UG" "UG" HPDF_COUNTRY_UG) ;; UGANDA
(test* "HPDF_COUNTRY_UA" "UA" HPDF_COUNTRY_UA) ;; UKRAINE
(test* "HPDF_COUNTRY_AE" "AE" HPDF_COUNTRY_AE) ;; UNITED ARAB EMIRATES
(test* "HPDF_COUNTRY_GB" "GB" HPDF_COUNTRY_GB) ;; UNITED KINGDOM
(test* "HPDF_COUNTRY_US" "US" HPDF_COUNTRY_US) ;; UNITED STATES
(test* "HPDF_COUNTRY_UM" "UM" HPDF_COUNTRY_UM) ;; UNITED STATES MINOR OUTLYING ISLANDS
(test* "HPDF_COUNTRY_UY" "UY" HPDF_COUNTRY_UY) ;; URUGUAY
(test* "HPDF_COUNTRY_UZ" "UZ" HPDF_COUNTRY_UZ) ;; UZBEKISTAN
(test* "HPDF_COUNTRY_VU" "VU" HPDF_COUNTRY_VU) ;; VANUATU
(test* "HPDF_COUNTRY_VA" "VA" HPDF_COUNTRY_VA) ;; VATICAN CITY STATE (HOLY SEE)
(test* "HPDF_COUNTRY_VE" "VE" HPDF_COUNTRY_VE) ;; VENEZUELA
(test* "HPDF_COUNTRY_VN" "VN" HPDF_COUNTRY_VN) ;; VIET NAM
(test* "HPDF_COUNTRY_VG" "VG" HPDF_COUNTRY_VG) ;; VIRGIN ISLANDS (BRITISH)
(test* "HPDF_COUNTRY_VI" "VI" HPDF_COUNTRY_VI) ;; VIRGIN ISLANDS (U.S.)
(test* "HPDF_COUNTRY_WF" "WF" HPDF_COUNTRY_WF) ;; WALLIS AND FUTUNA ISLANDS
(test* "HPDF_COUNTRY_EH" "EH" HPDF_COUNTRY_EH) ;; WESTERN SAHARA
(test* "HPDF_COUNTRY_YE" "YE" HPDF_COUNTRY_YE) ;; YEMEN
(test* "HPDF_COUNTRY_YU" "YU" HPDF_COUNTRY_YU) ;; YUGOSLAVIA
(test* "HPDF_COUNTRY_ZR" "ZR" HPDF_COUNTRY_ZR) ;; ZAIRE
(test* "HPDF_COUNTRY_ZM" "ZM" HPDF_COUNTRY_ZM) ;; ZAMBIA
(test* "HPDF_COUNTRY_ZW" "ZW" HPDF_COUNTRY_ZW) ;; ZIMBABWE

;; lang code definition
(test* "HPDF_LANG_AA" "aa" HPDF_LANG_AA) ;; Afar 
(test* "HPDF_LANG_AB" "ab" HPDF_LANG_AB) ;; Abkhazian 
(test* "HPDF_LANG_AF" "af" HPDF_LANG_AF) ;; Afrikaans 
(test* "HPDF_LANG_AM" "am" HPDF_LANG_AM) ;; Amharic 
(test* "HPDF_LANG_AR" "ar" HPDF_LANG_AR) ;; Arabic 
(test* "HPDF_LANG_AS" "as" HPDF_LANG_AS) ;; Assamese 
(test* "HPDF_LANG_AY" "ay" HPDF_LANG_AY) ;; Aymara 
(test* "HPDF_LANG_AZ" "az" HPDF_LANG_AZ) ;; Azerbaijani 
(test* "HPDF_LANG_BA" "ba" HPDF_LANG_BA) ;; Bashkir 
(test* "HPDF_LANG_BE" "be" HPDF_LANG_BE) ;; Byelorussian 
(test* "HPDF_LANG_BG" "bg" HPDF_LANG_BG) ;; Bulgarian 
(test* "HPDF_LANG_BH" "bh" HPDF_LANG_BH) ;; Bihari 
(test* "HPDF_LANG_BI" "bi" HPDF_LANG_BI) ;; Bislama 
(test* "HPDF_LANG_BN" "bn" HPDF_LANG_BN) ;; Bengali Bangla 
(test* "HPDF_LANG_BO" "bo" HPDF_LANG_BO) ;; Tibetan 
(test* "HPDF_LANG_BR" "br" HPDF_LANG_BR) ;; Breton 
(test* "HPDF_LANG_CA" "ca" HPDF_LANG_CA) ;; Catalan 
(test* "HPDF_LANG_CO" "co" HPDF_LANG_CO) ;; Corsican 
(test* "HPDF_LANG_CS" "cs" HPDF_LANG_CS) ;; Czech 
(test* "HPDF_LANG_CY" "cy" HPDF_LANG_CY) ;; Welsh 
(test* "HPDF_LANG_DA" "da" HPDF_LANG_DA) ;; Danish 
(test* "HPDF_LANG_DE" "de" HPDF_LANG_DE) ;; German 
(test* "HPDF_LANG_DZ" "dz" HPDF_LANG_DZ) ;; Bhutani 
(test* "HPDF_LANG_EL" "el" HPDF_LANG_EL) ;; Greek 
(test* "HPDF_LANG_EN" "en" HPDF_LANG_EN) ;; English 
(test* "HPDF_LANG_EO" "eo" HPDF_LANG_EO) ;; Esperanto 
(test* "HPDF_LANG_ES" "es" HPDF_LANG_ES) ;; Spanish 
(test* "HPDF_LANG_ET" "et" HPDF_LANG_ET) ;; Estonian 
(test* "HPDF_LANG_EU" "eu" HPDF_LANG_EU) ;; Basque 
(test* "HPDF_LANG_FA" "fa" HPDF_LANG_FA) ;; Persian 
(test* "HPDF_LANG_FI" "fi" HPDF_LANG_FI) ;; Finnish 
(test* "HPDF_LANG_FJ" "fj" HPDF_LANG_FJ) ;; Fiji 
(test* "HPDF_LANG_FO" "fo" HPDF_LANG_FO) ;; Faeroese 
(test* "HPDF_LANG_FR" "fr" HPDF_LANG_FR) ;; French 
(test* "HPDF_LANG_FY" "fy" HPDF_LANG_FY) ;; Frisian 
(test* "HPDF_LANG_GA" "ga" HPDF_LANG_GA) ;; Irish 
(test* "HPDF_LANG_GD" "gd" HPDF_LANG_GD) ;; Scots Gaelic 
(test* "HPDF_LANG_GL" "gl" HPDF_LANG_GL) ;; Galician 
(test* "HPDF_LANG_GN" "gn" HPDF_LANG_GN) ;; Guarani 
(test* "HPDF_LANG_GU" "gu" HPDF_LANG_GU) ;; Gujarati 
(test* "HPDF_LANG_HA" "ha" HPDF_LANG_HA) ;; Hausa 
(test* "HPDF_LANG_HI" "hi" HPDF_LANG_HI) ;; Hindi 
(test* "HPDF_LANG_HR" "hr" HPDF_LANG_HR) ;; Croatian 
(test* "HPDF_LANG_HU" "hu" HPDF_LANG_HU) ;; Hungarian 
(test* "HPDF_LANG_HY" "hy" HPDF_LANG_HY) ;; Armenian 
(test* "HPDF_LANG_IA" "ia" HPDF_LANG_IA) ;; Interlingua 
(test* "HPDF_LANG_IE" "ie" HPDF_LANG_IE) ;; Interlingue 
(test* "HPDF_LANG_IK" "ik" HPDF_LANG_IK) ;; Inupiak 
(test* "HPDF_LANG_IN" "in" HPDF_LANG_IN) ;; Indonesian 
(test* "HPDF_LANG_IS" "is" HPDF_LANG_IS) ;; Icelandic 
(test* "HPDF_LANG_IT" "it" HPDF_LANG_IT) ;; Italian 
(test* "HPDF_LANG_IW" "iw" HPDF_LANG_IW) ;; Hebrew 
(test* "HPDF_LANG_JA" "ja" HPDF_LANG_JA) ;; Japanese 
(test* "HPDF_LANG_JI" "ji" HPDF_LANG_JI) ;; Yiddish 
(test* "HPDF_LANG_JW" "jw" HPDF_LANG_JW) ;; Javanese 
(test* "HPDF_LANG_KA" "ka" HPDF_LANG_KA) ;; Georgian 
(test* "HPDF_LANG_KK" "kk" HPDF_LANG_KK) ;; Kazakh 
(test* "HPDF_LANG_KL" "kl" HPDF_LANG_KL) ;; Greenlandic 
(test* "HPDF_LANG_KM" "km" HPDF_LANG_KM) ;; Cambodian 
(test* "HPDF_LANG_KN" "kn" HPDF_LANG_KN) ;; Kannada 
(test* "HPDF_LANG_KO" "ko" HPDF_LANG_KO) ;; Korean 
(test* "HPDF_LANG_KS" "ks" HPDF_LANG_KS) ;; Kashmiri 
(test* "HPDF_LANG_KU" "ku" HPDF_LANG_KU) ;; Kurdish 
(test* "HPDF_LANG_KY" "ky" HPDF_LANG_KY) ;; Kirghiz 
(test* "HPDF_LANG_LA" "la" HPDF_LANG_LA) ;; Latin 
(test* "HPDF_LANG_LN" "ln" HPDF_LANG_LN) ;; Lingala 
(test* "HPDF_LANG_LO" "lo" HPDF_LANG_LO) ;; Laothian 
(test* "HPDF_LANG_LT" "lt" HPDF_LANG_LT) ;; Lithuanian 
(test* "HPDF_LANG_LV" "lv" HPDF_LANG_LV) ;; Latvian,Lettish 
(test* "HPDF_LANG_MG" "mg" HPDF_LANG_MG) ;; Malagasy 
(test* "HPDF_LANG_MI" "mi" HPDF_LANG_MI) ;; Maori 
(test* "HPDF_LANG_MK" "mk" HPDF_LANG_MK) ;; Macedonian 
(test* "HPDF_LANG_ML" "ml" HPDF_LANG_ML) ;; Malayalam 
(test* "HPDF_LANG_MN" "mn" HPDF_LANG_MN) ;; Mongolian 
(test* "HPDF_LANG_MO" "mo" HPDF_LANG_MO) ;; Moldavian 
(test* "HPDF_LANG_MR" "mr" HPDF_LANG_MR) ;; Marathi 
(test* "HPDF_LANG_MS" "ms" HPDF_LANG_MS) ;; Malay 
(test* "HPDF_LANG_MT" "mt" HPDF_LANG_MT) ;; Maltese 
(test* "HPDF_LANG_MY" "my" HPDF_LANG_MY) ;; Burmese 
(test* "HPDF_LANG_NA" "na" HPDF_LANG_NA) ;; Nauru 
(test* "HPDF_LANG_NE" "ne" HPDF_LANG_NE) ;; Nepali 
(test* "HPDF_LANG_NL" "nl" HPDF_LANG_NL) ;; Dutch 
(test* "HPDF_LANG_NO" "no" HPDF_LANG_NO) ;; Norwegian 
(test* "HPDF_LANG_OC" "oc" HPDF_LANG_OC) ;; Occitan 
(test* "HPDF_LANG_OM" "om" HPDF_LANG_OM) ;; (Afan)Oromo 
(test* "HPDF_LANG_OR" "or" HPDF_LANG_OR) ;; Oriya 
(test* "HPDF_LANG_PA" "pa" HPDF_LANG_PA) ;; Punjabi 
(test* "HPDF_LANG_PL" "pl" HPDF_LANG_PL) ;; Polish 
(test* "HPDF_LANG_PS" "ps" HPDF_LANG_PS) ;; Pashto,Pushto 
(test* "HPDF_LANG_PT" "pt" HPDF_LANG_PT) ;; Portuguese  
(test* "HPDF_LANG_QU" "qu" HPDF_LANG_QU) ;; Quechua 
(test* "HPDF_LANG_RM" "rm" HPDF_LANG_RM) ;; Rhaeto-Romance 
(test* "HPDF_LANG_RN" "rn" HPDF_LANG_RN) ;; Kirundi 
(test* "HPDF_LANG_RO" "ro" HPDF_LANG_RO) ;; Romanian 
(test* "HPDF_LANG_RU" "ru" HPDF_LANG_RU) ;; Russian 
(test* "HPDF_LANG_RW" "rw" HPDF_LANG_RW) ;; Kinyarwanda 
(test* "HPDF_LANG_SA" "sa" HPDF_LANG_SA) ;; Sanskrit 
(test* "HPDF_LANG_SD" "sd" HPDF_LANG_SD) ;; Sindhi 
(test* "HPDF_LANG_SG" "sg" HPDF_LANG_SG) ;; Sangro 
(test* "HPDF_LANG_SH" "sh" HPDF_LANG_SH) ;; Serbo-Croatian 
(test* "HPDF_LANG_SI" "si" HPDF_LANG_SI) ;; Singhalese 
(test* "HPDF_LANG_SK" "sk" HPDF_LANG_SK) ;; Slovak 
(test* "HPDF_LANG_SL" "sl" HPDF_LANG_SL) ;; Slovenian 
(test* "HPDF_LANG_SM" "sm" HPDF_LANG_SM) ;; Samoan 
(test* "HPDF_LANG_SN" "sn" HPDF_LANG_SN) ;; Shona 
(test* "HPDF_LANG_SO" "so" HPDF_LANG_SO) ;; Somali 
(test* "HPDF_LANG_SQ" "sq" HPDF_LANG_SQ) ;; Albanian 
(test* "HPDF_LANG_SR" "sr" HPDF_LANG_SR) ;; Serbian 
(test* "HPDF_LANG_SS" "ss" HPDF_LANG_SS) ;; Siswati 
(test* "HPDF_LANG_ST" "st" HPDF_LANG_ST) ;; Sesotho 
(test* "HPDF_LANG_SU" "su" HPDF_LANG_SU) ;; Sundanese 
(test* "HPDF_LANG_SV" "sv" HPDF_LANG_SV) ;; Swedish 
(test* "HPDF_LANG_SW" "sw" HPDF_LANG_SW) ;; Swahili 
(test* "HPDF_LANG_TA" "ta" HPDF_LANG_TA) ;; Tamil 
(test* "HPDF_LANG_TE" "te" HPDF_LANG_TE) ;; Tegulu 
(test* "HPDF_LANG_TG" "tg" HPDF_LANG_TG) ;; Tajik 
(test* "HPDF_LANG_TH" "th" HPDF_LANG_TH) ;; Thai 
(test* "HPDF_LANG_TI" "ti" HPDF_LANG_TI) ;; Tigrinya 
(test* "HPDF_LANG_TK" "tk" HPDF_LANG_TK) ;; Turkmen 
(test* "HPDF_LANG_TL" "tl" HPDF_LANG_TL) ;; Tagalog 
(test* "HPDF_LANG_TN" "tn" HPDF_LANG_TN) ;; Setswanato Tonga 
(test* "HPDF_LANG_TR" "tr" HPDF_LANG_TR) ;; Turkish 
(test* "HPDF_LANG_TS" "ts" HPDF_LANG_TS) ;; Tsonga 
(test* "HPDF_LANG_TT" "tt" HPDF_LANG_TT) ;; Tatar 
(test* "HPDF_LANG_TW" "tw" HPDF_LANG_TW) ;; Twi 
(test* "HPDF_LANG_UK" "uk" HPDF_LANG_UK) ;; Ukrainian 
(test* "HPDF_LANG_UR" "ur" HPDF_LANG_UR) ;; Urdu 
(test* "HPDF_LANG_UZ" "uz" HPDF_LANG_UZ) ;; Uzbek 
(test* "HPDF_LANG_VI" "vi" HPDF_LANG_VI) ;; Vietnamese 
(test* "HPDF_LANG_VO" "vo" HPDF_LANG_VO) ;; Volapuk 
(test* "HPDF_LANG_WO" "wo" HPDF_LANG_WO) ;; Wolof 
(test* "HPDF_LANG_XH" "xh" HPDF_LANG_XH) ;; Xhosa 
(test* "HPDF_LANG_YO" "yo" HPDF_LANG_YO) ;; Yoruba 
(test* "HPDF_LANG_ZH" "zh" HPDF_LANG_ZH) ;; Chinese
(test* "HPDF_LANG_ZU" "zu" HPDF_LANG_ZU) ;; Zulu

(let* ((doc (hpdf-new)))
  (hpdf-savetofile doc "test/page_0.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-addpage doc)))
  (hpdf-savetofile doc "test/page_1.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-addpage doc))
       (page_1 (hpdf-addpage doc)))
  (hpdf-savetofile doc "test/page_2.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-addpage doc))
       (dummy (hpdf-savetofile doc "test/page1_1.pdf"))
       (page_1 (hpdf-addpage doc))
       (dummy (hpdf-savetofile doc "test/page1_2.pdf"))
       )
  (hpdf-savetofile doc "test/page1.pdf"))

(let* ((doc (hpdf-new))
       (font (hpdf-get-font doc "Helvetica" ""))
       (page_1 (hpdf-addpage doc))
       (font (hpdf-page-setfontandsize page_1 font 14))
       (s (hpdf-page-begintext page_1))
       (null (print s))
       (dummy (hpdf-page-showtext page_1 "Hello, World"))
       (dummy (hpdf-page-endtext page_1))
       )
  (hpdf-savetofile doc "test/hpdf_showtext.pdf"))

;; epilogue
(test-end)





