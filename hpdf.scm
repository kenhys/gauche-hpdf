;;;
;;; hpdf
;;;

(define-module hpdf
  (export
    <hDoc>
    <hPage>
    <hPages>
    <hStream>
    <hImage>
    <hFont>
    <hOutline>
    <hEncoder>
    <hDestination>
    <hXObject>
    <hAnnotation>
    <hExtGState>

    ;; primitive class
    <hPdfPoint>
    <hPdfBox>
    <hPdfRect>
    <hPdfRGBColor>
    <hPdfCMYKColor>

    hpdf-getversion
    hpdf-new
    hpdf-free
    hpdf-newdoc
    hpdf-freedoc
    hpdf-freedocall
    hpdf-addpage
    hpdf-savetofile

    hpdf-page-setwidth
    hpdf-page-setheight
    hpdf-page-setsize
    hpdf-page-setrotate
    hpdf-page-getwidth
    hpdf-page-getheight
    hpdf-page-createdestination
    hpdf-page-createtextannot
    hpdf-page-createlinkannot
    hpdf-page-createurilinkannot
    hpdf-page-textwidth
    ;;hpdf-page-measuretext
    hpdf-page-getgmode
    hpdf-page-getcurrentpos
    hpdf-page-getcurrenttextpos
    hpdf-page-getcurrentfont
    hpdf-page-getcurrentfontsize
    hpdf-page-gettransmatrix
    hpdf-page-getlinewidth
    hpdf-page-getlinecap
    hpdf-page-getlinejoin
    hpdf-page-getmiterlimit
    hpdf-page-getdash
    hpdf-page-getflat
    hpdf-page-getcharspace
    hpdf-page-getwordspace
    hpdf-page-gethorizontalscalling
    hpdf-page-gettextleading
    hpdf-page-gettextrenderingmode
    hpdf-page-gettextrise
    hpdf-page-getrgbfill
    hpdf-page-getrgbstroke
    hpdf-page-getcmykfill
    hpdf-page-getcmykstroke
    hpdf-page-getgrayfill
    hpdf-page-getgraystroke
    hpdf-page-getstrokingcolorspace
    hpdf-page-getfillingcolorspace
    hpdf-page-gettextmatrix
    hpdf-page-getgstatedepth
    hpdf-page-setslideshow

    ;;
    ;; Graphics API
    ;;
    hpdf-page-setlinewidth
    hpdf-page-setlinecap
    hpdf-page-setlinejoin
    hpdf-page-setmiterlimit
    hpdf-page-setdash
    hpdf-page-setextgstate
    hpdf-page-gsave
    hpdf-page-grestore
    hpdf-page-concat
    hpdf-page-moveto
    hpdf-page-lineto
    hpdf-page-curveto
    hpdf-page-curveto2
    hpdf-page-curveto3
    hpdf-page-closepath
    hpdf-page-rectangle
    hpdf-page-stroke
    hpdf-page-closepathstroke
    hpdf-page-fill
    hpdf-page-eofill
    hpdf-page-fillstroke
    hpdf-page-eofillstroke
    hpdf-page-closepathfillstroke
    hpdf-page-closepatheofillstroke
    hpdf-page-endpath
    hpdf-page-clip
    hpdf-page-eoclip
    hpdf-page-begintext
    hpdf-page-endtext
    hpdf-page-setcharspace
    hpdf-page-setwordspace
    hpdf-page-sethorizontalscalling
    hpdf-page-settextleading
    hpdf-page-setfontandsize
    hpdf-page-settextrenderingmode
    hpdf-page-settextrise
    hpdf-page-movetextpos
    hpdf-page-movetextpos2
    hpdf-page-settextmatrix
    hpdf-page-movetonextline
    hpdf-page-showtext
    hpdf-page-showtextnextline
    hpdf-page-showtextnextlineex
    hpdf-page-setgrayfill
    hpdf-page-setgraystroke
    hpdf-page-setrgbfill
    hpdf-page-setrgbstroke
    hpdf-page-setcmykfill
    hpdf-page-setcmykstroke
    hpdf-page-executexobject
    hpdf-page-drawimage
    hpdf-page-circle
    hpdf-page-arc
    hpdf-page-textout
    hpdf-page-textrect

    ;; Font Handling
    hpdf-getfont
    hpdf-loadtype1fontfromfile
    hpdf-loadttfontfromfile
    hpdf-loadttfontfromfile2
    hpdf-addpagelabel
    hpdf-usejpfonts
    hpdf-usekrfonts
    hpdf-usecnsfonts
    hpdf-usecntfonts

    ;; Constant
    HPDF_TRUE
    HPDF_FALSE
    HPDF_OK
    HPDF_NOERROR

    HPDF_DEF_FONT
	HPDF_DEF_PAGE_LAYOUT
	HPDF_DEF_PAGE_MODE
	HPDF_DEF_WORDSPACE
	HPDF_DEF_CHARSPACE
	HPDF_DEF_FONTSIZE
	HPDF_DEF_HSCALING
	HPDF_DEF_LEADING
	HPDF_DEF_RENDERING_MODE
	HPDF_DEF_RISE
	HPDF_DEF_RAISE
	HPDF_DEF_LINEWIDTH
	HPDF_DEF_LINECAP
	HPDF_DEF_LINEJOIN
	HPDF_DEF_MITERLIMIT
	HPDF_DEF_FLATNESS
	HPDF_DEF_PAGE_NUM

	HPDF_BS_DEF_WIDTH

    HPDF_DEF_PAGE_WIDTH
    HPDF_DEF_PAGE_HEIGHT

    HPDF_VERSION_TEXT

    HPDF_GMODE_PAGE_DESCRIPTION
    HPDF_GMODE_PATH_OBJECT
    HPDF_GMODE_TEXT_OBJECT
    HPDF_GMODE_CLIPPING_PATH
    HPDF_GMODE_SHADING
    HPDF_GMODE_INLINE_IMAGE
    HPDF_GMODE_EXTERNAL_OBJECT

    HPDF_COUNTRY_AF ;; AFGHANISTAN
    HPDF_COUNTRY_AL ;; ALBANIA
    HPDF_COUNTRY_DZ ;; ALGERIA
    HPDF_COUNTRY_AS ;; AMERICAN SAMOA
    HPDF_COUNTRY_AD ;; ANDORRA
    HPDF_COUNTRY_AO ;; ANGOLA
    HPDF_COUNTRY_AI ;; ANGUILLA
    HPDF_COUNTRY_AQ ;; ANTARCTICA
    HPDF_COUNTRY_AG ;; ANTIGUA AND BARBUDA
    HPDF_COUNTRY_AR ;; ARGENTINA
    HPDF_COUNTRY_AM ;; ARMENIA
    HPDF_COUNTRY_AW ;; ARUBA
    HPDF_COUNTRY_AU ;; AUSTRALIA
    HPDF_COUNTRY_AT ;; AUSTRIA
    HPDF_COUNTRY_AZ ;; AZERBAIJAN
    HPDF_COUNTRY_BS ;; BAHAMAS
    HPDF_COUNTRY_BH ;; BAHRAIN
    HPDF_COUNTRY_BD ;; BANGLADESH
    HPDF_COUNTRY_BB ;; BARBADOS
    HPDF_COUNTRY_BY ;; BELARUS
    HPDF_COUNTRY_BE ;; BELGIUM
    HPDF_COUNTRY_BZ ;; BELIZE
    HPDF_COUNTRY_BJ ;; BENIN
   HPDF_COUNTRY_BM ;; BERMUDA
   HPDF_COUNTRY_BT ;; BHUTAN
   HPDF_COUNTRY_BO ;; BOLIVIA
   HPDF_COUNTRY_BA ;; BOSNIA AND HERZEGOWINA
   HPDF_COUNTRY_BW ;; BOTSWANA
   HPDF_COUNTRY_BV ;; BOUVET ISLAND
   HPDF_COUNTRY_BR ;; BRAZIL
   HPDF_COUNTRY_IO ;; BRITISH INDIAN OCEAN TERRITORY
   HPDF_COUNTRY_BN ;; BRUNEI DARUSSALAM
   HPDF_COUNTRY_BG ;; BULGARIA
   HPDF_COUNTRY_BF ;; BURKINA FASO
   HPDF_COUNTRY_BI ;; BURUNDI
   HPDF_COUNTRY_KH ;; CAMBODIA
   HPDF_COUNTRY_CM ;; CAMEROON
   HPDF_COUNTRY_CA ;; CANADA
   HPDF_COUNTRY_CV ;; CAPE VERDE
   HPDF_COUNTRY_KY ;; CAYMAN ISLANDS
   HPDF_COUNTRY_CF ;; CENTRAL AFRICAN REPUBLIC
   HPDF_COUNTRY_TD ;; CHAD
   HPDF_COUNTRY_CL ;; CHILE
   HPDF_COUNTRY_CN ;; CHINA
   HPDF_COUNTRY_CX ;; CHRISTMAS ISLAND
   HPDF_COUNTRY_CC ;; COCOS (KEELING) ISLANDS
   HPDF_COUNTRY_CO ;; COLOMBIA
   HPDF_COUNTRY_KM ;; COMOROS
   HPDF_COUNTRY_CG ;; CONGO
   HPDF_COUNTRY_CK ;; COOK ISLANDS
   HPDF_COUNTRY_CR ;; COSTA RICA
   HPDF_COUNTRY_CI ;; COTE D'IVOIRE
   HPDF_COUNTRY_HR ;; CROATIA (local name: Hrvatska)
   HPDF_COUNTRY_CU ;; CUBA
   HPDF_COUNTRY_CY ;; CYPRUS
   HPDF_COUNTRY_CZ ;; CZECH REPUBLIC
   HPDF_COUNTRY_DK ;; DENMARK
   HPDF_COUNTRY_DJ ;; DJIBOUTI
   HPDF_COUNTRY_DM ;; DOMINICA
   HPDF_COUNTRY_DO ;; DOMINICAN REPUBLIC
   HPDF_COUNTRY_TP ;; EAST TIMOR
   HPDF_COUNTRY_EC ;; ECUADOR
   HPDF_COUNTRY_EG ;; EGYPT
   HPDF_COUNTRY_SV ;; EL SALVADOR
   HPDF_COUNTRY_GQ ;; EQUATORIAL GUINEA
   HPDF_COUNTRY_ER ;; ERITREA
   HPDF_COUNTRY_EE ;; ESTONIA
   HPDF_COUNTRY_ET ;; ETHIOPIA
   HPDF_COUNTRY_FK ;; FALKLAND ISLANDS (MALVINAS)
   HPDF_COUNTRY_FO ;; FAROE ISLANDS
   HPDF_COUNTRY_FJ ;; FIJI
   HPDF_COUNTRY_FI ;; FINLAND
   HPDF_COUNTRY_FR ;; FRANCE
   HPDF_COUNTRY_FX ;; FRANCE, METROPOLITAN
   HPDF_COUNTRY_GF ;; FRENCH GUIANA
   HPDF_COUNTRY_PF ;; FRENCH POLYNESIA
   HPDF_COUNTRY_TF ;; FRENCH SOUTHERN TERRITORIES
   HPDF_COUNTRY_GA ;; GABON
   HPDF_COUNTRY_GM ;; GAMBIA
   HPDF_COUNTRY_GE ;; GEORGIA
   HPDF_COUNTRY_DE ;; GERMANY
   HPDF_COUNTRY_GH ;; GHANA
   HPDF_COUNTRY_GI ;; GIBRALTAR
   HPDF_COUNTRY_GR ;; GREECE
   HPDF_COUNTRY_GL ;; GREENLAND
   HPDF_COUNTRY_GD ;; GRENADA
   HPDF_COUNTRY_GP ;; GUADELOUPE
   HPDF_COUNTRY_GU ;; GUAM
   HPDF_COUNTRY_GT ;; GUATEMALA
   HPDF_COUNTRY_GN ;; GUINEA
   HPDF_COUNTRY_GW ;; GUINEA-BISSAU
   HPDF_COUNTRY_GY ;; GUYANA
   HPDF_COUNTRY_HT ;; HAITI
   HPDF_COUNTRY_HM ;; HEARD AND MC DONALD ISLANDS
   HPDF_COUNTRY_HN ;; HONDURAS
   HPDF_COUNTRY_HK ;; HONG KONG
   HPDF_COUNTRY_HU ;; HUNGARY
   HPDF_COUNTRY_IS ;; ICELAND
   HPDF_COUNTRY_IN ;; INDIA
   HPDF_COUNTRY_ID ;; INDONESIA
   HPDF_COUNTRY_IR ;; IRAN (ISLAMIC REPUBLIC OF)
   HPDF_COUNTRY_IQ ;; IRAQ
   HPDF_COUNTRY_IE ;; IRELAND
   HPDF_COUNTRY_IL ;; ISRAEL
   HPDF_COUNTRY_IT ;; ITALY
   HPDF_COUNTRY_JM ;; JAMAICA
   HPDF_COUNTRY_JP ;; JAPAN
   HPDF_COUNTRY_JO ;; JORDAN
   HPDF_COUNTRY_KZ ;; KAZAKHSTAN
   HPDF_COUNTRY_KE ;; KENYA
   HPDF_COUNTRY_KI ;; KIRIBATI
   HPDF_COUNTRY_KP ;; KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF
   HPDF_COUNTRY_KR ;; KOREA, REPUBLIC OF
   HPDF_COUNTRY_KW ;; KUWAIT
   HPDF_COUNTRY_KG ;; KYRGYZSTAN
   HPDF_COUNTRY_LA ;; LAO PEOPLE'S DEMOCRATIC REPUBLIC
   HPDF_COUNTRY_LV ;; LATVIA
   HPDF_COUNTRY_LB ;; LEBANON
   HPDF_COUNTRY_LS ;; LESOTHO
   HPDF_COUNTRY_LR ;; LIBERIA
   HPDF_COUNTRY_LY ;; LIBYAN ARAB JAMAHIRIYA
   HPDF_COUNTRY_LI ;; LIECHTENSTEIN
   HPDF_COUNTRY_LT ;; LITHUANIA
   HPDF_COUNTRY_LU ;; LUXEMBOURG
   HPDF_COUNTRY_MO ;; MACAU
   HPDF_COUNTRY_MK ;; MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF
   HPDF_COUNTRY_MG ;; MADAGASCAR
   HPDF_COUNTRY_MW ;; MALAWI
   HPDF_COUNTRY_MY ;; MALAYSIA
   HPDF_COUNTRY_MV ;; MALDIVES
   HPDF_COUNTRY_ML ;; MALI
   HPDF_COUNTRY_MT ;; MALTA
   HPDF_COUNTRY_MH ;; MARSHALL ISLANDS
   HPDF_COUNTRY_MQ ;; MARTINIQUE
   HPDF_COUNTRY_MR ;; MAURITANIA
   HPDF_COUNTRY_MU ;; MAURITIUS
   HPDF_COUNTRY_YT ;; MAYOTTE
   HPDF_COUNTRY_MX ;; MEXICO
   HPDF_COUNTRY_FM ;; MICRONESIA, FEDERATED STATES OF
   HPDF_COUNTRY_MD ;; MOLDOVA, REPUBLIC OF
   HPDF_COUNTRY_MC ;; MONACO
   HPDF_COUNTRY_MN ;; MONGOLIA
   HPDF_COUNTRY_MS ;; MONTSERRAT
   HPDF_COUNTRY_MA ;; MOROCCO
   HPDF_COUNTRY_MZ ;; MOZAMBIQUE
   HPDF_COUNTRY_MM ;; MYANMAR
   HPDF_COUNTRY_NA ;; NAMIBIA
   HPDF_COUNTRY_NR ;; NAURU
   HPDF_COUNTRY_NP ;; NEPAL
   HPDF_COUNTRY_NL ;; NETHERLANDS
   HPDF_COUNTRY_AN ;; NETHERLANDS ANTILLES
   HPDF_COUNTRY_NC ;; NEW CALEDONIA
   HPDF_COUNTRY_NZ ;; NEW ZEALAND
   HPDF_COUNTRY_NI ;; NICARAGUA
   HPDF_COUNTRY_NE ;; NIGER
   HPDF_COUNTRY_NG ;; NIGERIA
   HPDF_COUNTRY_NU ;; NIUE
   HPDF_COUNTRY_NF ;; NORFOLK ISLAND
   HPDF_COUNTRY_MP ;; NORTHERN MARIANA ISLANDS
   HPDF_COUNTRY_NO ;; NORWAY
   HPDF_COUNTRY_OM ;; OMAN
   HPDF_COUNTRY_PK ;; PAKISTAN
   HPDF_COUNTRY_PW ;; PALAU
   HPDF_COUNTRY_PA ;; PANAMA
   HPDF_COUNTRY_PG ;; PAPUA NEW GUINEA
   HPDF_COUNTRY_PY ;; PARAGUAY
   HPDF_COUNTRY_PE ;; PERU
   HPDF_COUNTRY_PH ;; PHILIPPINES
   HPDF_COUNTRY_PN ;; PITCAIRN
   HPDF_COUNTRY_PL ;; POLAND
   HPDF_COUNTRY_PT ;; PORTUGAL
   HPDF_COUNTRY_PR ;; PUERTO RICO
   HPDF_COUNTRY_QA ;; QATAR
   HPDF_COUNTRY_RE ;; REUNION
   HPDF_COUNTRY_RO ;; ROMANIA
   HPDF_COUNTRY_RU ;; RUSSIAN FEDERATION
   HPDF_COUNTRY_RW ;; RWANDA
   HPDF_COUNTRY_KN ;; SAINT KITTS AND NEVIS
   HPDF_COUNTRY_LC ;; SAINT LUCIA
   HPDF_COUNTRY_VC ;; SAINT VINCENT AND THE GRENADINES
   HPDF_COUNTRY_WS ;; SAMOA
   HPDF_COUNTRY_SM ;; SAN MARINO
   HPDF_COUNTRY_ST ;; SAO TOME AND PRINCIPE
   HPDF_COUNTRY_SA ;; SAUDI ARABIA
   HPDF_COUNTRY_SN ;; SENEGAL
   HPDF_COUNTRY_SC ;; SEYCHELLES
   HPDF_COUNTRY_SL ;; SIERRA LEONE
   HPDF_COUNTRY_SG ;; SINGAPORE
   HPDF_COUNTRY_SK ;; SLOVAKIA (Slovak Republic)
   HPDF_COUNTRY_SI ;; SLOVENIA
   HPDF_COUNTRY_SB ;; SOLOMON ISLANDS
   HPDF_COUNTRY_SO ;; SOMALIA
   HPDF_COUNTRY_ZA ;; SOUTH AFRICA
   HPDF_COUNTRY_ES ;; SPAIN
   HPDF_COUNTRY_LK ;; SRI LANKA
   HPDF_COUNTRY_SH ;; ST. HELENA
   HPDF_COUNTRY_PM ;; ST. PIERRE AND MIQUELON
   HPDF_COUNTRY_SD ;; SUDAN
   HPDF_COUNTRY_SR ;; SURINAME
   HPDF_COUNTRY_SJ ;; SVALBARD AND JAN MAYEN ISLANDS
   HPDF_COUNTRY_SZ ;; SWAZILAND
   HPDF_COUNTRY_SE ;; SWEDEN
   HPDF_COUNTRY_CH ;; SWITZERLAND
   HPDF_COUNTRY_SY ;; SYRIAN ARAB REPUBLIC
   HPDF_COUNTRY_TW ;; TAIWAN, PROVINCE OF CHINA
   HPDF_COUNTRY_TJ ;; TAJIKISTAN
   HPDF_COUNTRY_TZ ;; TANZANIA, UNITED REPUBLIC OF
   HPDF_COUNTRY_TH ;; THAILAND
   HPDF_COUNTRY_TG ;; TOGO
   HPDF_COUNTRY_TK ;; TOKELAU
   HPDF_COUNTRY_TO ;; TONGA
   HPDF_COUNTRY_TT ;; TRINIDAD AND TOBAGO
   HPDF_COUNTRY_TN ;; TUNISIA
   HPDF_COUNTRY_TR ;; TURKEY
   HPDF_COUNTRY_TM ;; TURKMENISTAN
   HPDF_COUNTRY_TC ;; TURKS AND CAICOS ISLANDS
   HPDF_COUNTRY_TV ;; TUVALU
   HPDF_COUNTRY_UG ;; UGANDA
   HPDF_COUNTRY_UA ;; UKRAINE
   HPDF_COUNTRY_AE ;; UNITED ARAB EMIRATES
   HPDF_COUNTRY_GB ;; UNITED KINGDOM
   HPDF_COUNTRY_US ;; UNITED STATES
   HPDF_COUNTRY_UM ;; UNITED STATES MINOR OUTLYING ISLANDS
   HPDF_COUNTRY_UY ;; URUGUAY
   HPDF_COUNTRY_UZ ;; UZBEKISTAN
   HPDF_COUNTRY_VU ;; VANUATU
   HPDF_COUNTRY_VA ;; VATICAN CITY STATE (HOLY SEE)
   HPDF_COUNTRY_VE ;; VENEZUELA
   HPDF_COUNTRY_VN ;; VIET NAM
   HPDF_COUNTRY_VG ;; VIRGIN ISLANDS (BRITISH)
   HPDF_COUNTRY_VI ;; VIRGIN ISLANDS (U.S.)
   HPDF_COUNTRY_WF ;; WALLIS AND FUTUNA ISLANDS
   HPDF_COUNTRY_EH ;; WESTERN SAHARA
   HPDF_COUNTRY_YE ;; YEMEN
   HPDF_COUNTRY_YU ;; YUGOSLAVIA
   HPDF_COUNTRY_ZR ;; ZAIRE
   HPDF_COUNTRY_ZM ;; ZAMBIA
   HPDF_COUNTRY_ZW ;; ZIMBABWE

;; lang code definition
   HPDF_LANG_AA ;; Afar 
   HPDF_LANG_AB ;; Abkhazian 
   HPDF_LANG_AF ;; Afrikaans 
   HPDF_LANG_AM ;; Amharic 
   HPDF_LANG_AR ;; Arabic 
   HPDF_LANG_AS ;; Assamese 
   HPDF_LANG_AY ;; Aymara 
   HPDF_LANG_AZ ;; Azerbaijani 
   HPDF_LANG_BA ;; Bashkir 
   HPDF_LANG_BE ;; Byelorussian 
   HPDF_LANG_BG ;; Bulgarian 
   HPDF_LANG_BH ;; Bihari 
   HPDF_LANG_BI ;; Bislama 
   HPDF_LANG_BN ;; Bengali Bangla 
   HPDF_LANG_BO ;; Tibetan 
   HPDF_LANG_BR ;; Breton 
   HPDF_LANG_CA ;; Catalan 
   HPDF_LANG_CO ;; Corsican 
   HPDF_LANG_CS ;; Czech 
   HPDF_LANG_CY ;; Welsh 
   HPDF_LANG_DA ;; Danish 
   HPDF_LANG_DE ;; German 
   HPDF_LANG_DZ ;; Bhutani 
   HPDF_LANG_EL ;; Greek 
   HPDF_LANG_EN ;; English 
   HPDF_LANG_EO ;; Esperanto 
   HPDF_LANG_ES ;; Spanish 
   HPDF_LANG_ET ;; Estonian 
   HPDF_LANG_EU ;; Basque 
   HPDF_LANG_FA ;; Persian 
   HPDF_LANG_FI ;; Finnish 
   HPDF_LANG_FJ ;; Fiji 
   HPDF_LANG_FO ;; Faeroese 
   HPDF_LANG_FR ;; French 
   HPDF_LANG_FY ;; Frisian 
   HPDF_LANG_GA ;; Irish 
   HPDF_LANG_GD ;; Scots Gaelic 
   HPDF_LANG_GL ;; Galician 
   HPDF_LANG_GN ;; Guarani 
   HPDF_LANG_GU ;; Gujarati 
   HPDF_LANG_HA ;; Hausa 
   HPDF_LANG_HI ;; Hindi 
   HPDF_LANG_HR ;; Croatian 
   HPDF_LANG_HU ;; Hungarian 
   HPDF_LANG_HY ;; Armenian 
   HPDF_LANG_IA ;; Interlingua 
   HPDF_LANG_IE ;; Interlingue 
   HPDF_LANG_IK ;; Inupiak 
   HPDF_LANG_IN ;; Indonesian 
   HPDF_LANG_IS ;; Icelandic 
   HPDF_LANG_IT ;; Italian 
   HPDF_LANG_IW ;; Hebrew 
   HPDF_LANG_JA ;; Japanese 
   HPDF_LANG_JI ;; Yiddish 
   HPDF_LANG_JW ;; Javanese 
   HPDF_LANG_KA ;; Georgian 
   HPDF_LANG_KK ;; Kazakh 
   HPDF_LANG_KL ;; Greenlandic 
   HPDF_LANG_KM ;; Cambodian 
   HPDF_LANG_KN ;; Kannada 
   HPDF_LANG_KO ;; Korean 
   HPDF_LANG_KS ;; Kashmiri 
   HPDF_LANG_KU ;; Kurdish 
   HPDF_LANG_KY ;; Kirghiz 
   HPDF_LANG_LA ;; Latin 
   HPDF_LANG_LN ;; Lingala 
   HPDF_LANG_LO ;; Laothian 
   HPDF_LANG_LT ;; Lithuanian 
   HPDF_LANG_LV ;; Latvian,Lettish 
   HPDF_LANG_MG ;; Malagasy 
   HPDF_LANG_MI ;; Maori 
   HPDF_LANG_MK ;; Macedonian 
   HPDF_LANG_ML ;; Malayalam 
   HPDF_LANG_MN ;; Mongolian 
   HPDF_LANG_MO ;; Moldavian 
   HPDF_LANG_MR ;; Marathi 
   HPDF_LANG_MS ;; Malay 
   HPDF_LANG_MT ;; Maltese 
   HPDF_LANG_MY ;; Burmese 
   HPDF_LANG_NA ;; Nauru 
   HPDF_LANG_NE ;; Nepali 
   HPDF_LANG_NL ;; Dutch 
   HPDF_LANG_NO ;; Norwegian 
   HPDF_LANG_OC ;; Occitan 
   HPDF_LANG_OM ;; (Afan)Oromo 
   HPDF_LANG_OR ;; Oriya 
   HPDF_LANG_PA ;; Punjabi 
   HPDF_LANG_PL ;; Polish 
   HPDF_LANG_PS ;; Pashto,Pushto 
   HPDF_LANG_PT ;; Portuguese  
   HPDF_LANG_QU ;; Quechua 
   HPDF_LANG_RM ;; Rhaeto-Romance 
   HPDF_LANG_RN ;; Kirundi 
   HPDF_LANG_RO ;; Romanian 
   HPDF_LANG_RU ;; Russian 
   HPDF_LANG_RW ;; Kinyarwanda 
   HPDF_LANG_SA ;; Sanskrit 
   HPDF_LANG_SD ;; Sindhi 
   HPDF_LANG_SG ;; Sangro 
   HPDF_LANG_SH ;; Serbo-Croatian 
   HPDF_LANG_SI ;; Singhalese 
   HPDF_LANG_SK ;; Slovak 
   HPDF_LANG_SL ;; Slovenian 
   HPDF_LANG_SM ;; Samoan 
   HPDF_LANG_SN ;; Shona 
   HPDF_LANG_SO ;; Somali 
   HPDF_LANG_SQ ;; Albanian 
   HPDF_LANG_SR ;; Serbian 
   HPDF_LANG_SS ;; Siswati 
   HPDF_LANG_ST ;; Sesotho 
   HPDF_LANG_SU ;; Sundanese 
   HPDF_LANG_SV ;; Swedish 
   HPDF_LANG_SW ;; Swahili 
   HPDF_LANG_TA ;; Tamil 
   HPDF_LANG_TE ;; Tegulu 
   HPDF_LANG_TG ;; Tajik 
   HPDF_LANG_TH ;; Thai 
   HPDF_LANG_TI ;; Tigrinya 
   HPDF_LANG_TK ;; Turkmen 
   HPDF_LANG_TL ;; Tagalog 
   HPDF_LANG_TN ;; Setswanato Tonga 
   HPDF_LANG_TR ;; Turkish 
   HPDF_LANG_TS ;; Tsonga 
   HPDF_LANG_TT ;; Tatar 
   HPDF_LANG_TW ;; Twi 
   HPDF_LANG_UK ;; Ukrainian 
   HPDF_LANG_UR ;; Urdu 
   HPDF_LANG_UZ ;; Uzbek 
   HPDF_LANG_VI ;; Vietnamese 
   HPDF_LANG_VO ;; Volapuk 
   HPDF_LANG_WO ;; Wolof 
   HPDF_LANG_XH ;; Xhosa 
   HPDF_LANG_YO ;; Yoruba 
   HPDF_LANG_ZH ;; Chinese
   HPDF_LANG_ZU ;; Zulu
   ;;
    )
  )
(select-module hpdf)

;; Loads extension
(dynamic-load "hpdf")

;;
;; Put your Scheme definitions here
;;

;; Epilogue
(provide "hpdf")


