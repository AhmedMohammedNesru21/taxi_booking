import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';


class DatabaseConnection
{

  final String Insert_Regions="INSERT INTO Regions (Id, Region_Name, Sync_Date, Is_Removed) VALUES " +
      "(1	,'Tigray', '1970-01-01','0'),"+
      "(2	,'Afar  ', '1970-01-01','0'),"+
      "(3	,'Amhara', '1970-01-01','0'),"+
      "(4	,'Oromia', '1970-01-01','0'),"+
      "(8	,'Benishangul Gumz', '1970-01-01','0'),"+
      "(6	,'SNNPRG', '1970-01-01','0'),"+
      "(12,'Gambela', '1970-01-01','0'),"+
      "(14,'Addis Ababa', '1970-01-01','0'),"+
      "(5	,'Somalia', '1970-01-01','0'),"+
      "(13,'Harar', '1970-01-01','0'),"+
      "(7	,'Dire Dawa', '1970-01-01','0'),"+
      "(15,'JIJIGA', '1970-01-01','0');";


  final String Insert_Towns="INSERT INTO Subcity (Id, Region_Id,Town_Name, Sync_Date, Is_Removed) VALUES " +
     "(90,'14','Addis Ketema','1970-01-01','0'),"+
     "(91,'14','Akaki Kalti','1970-01-01','0'),"+
     "(92,'14','Arada','1970-01-01','0'),"+
     "(93,'14','Bole','1970-01-01','0'),"+
     "(94,'14','Gulele','1970-01-01','0'),"+
     "(95,'14','Kirkos','1970-01-01','0'),"+
     "(96,'14','Kolfa Kerano','1970-01-01','0'),"+
     "(97,'14','Lideta','1970-01-01','0'),"+
     "(98,'14','Nefas silk Lafto','1970-01-01','0'),"+
     "(99,'14','Yeka','1970-01-01','0'),"+
      "(1,'1','NORTH WEST TIGRAY','1970-01-01','0'),"+
      "(10,'2','ZONE 4','1970-01-01','0'),"+
      "(11,'2','ZONE 5','1970-01-01','0'),"+
      "(12,'3','NORTH GONDAR','1970-01-01','0'),"+
      "(13,'3','SOUTH GONDAR','1970-01-01','0'),"+
      "(14,'3','NORTH WELLO','1970-01-01','0'),"+
      "(15,'3','SOUTH WELLO','1970-01-01','0'),"+
      "(16,'3','NORTH SHEWA','1970-01-01','0'),"+
      "(17,'3','EAST GOJAM ','1970-01-01','0'),"+
      "(18,'3','WEST GOJAM','1970-01-01','0'),"+
      "(19,'3','WAG HIMRA','1970-01-01','0'),"+
      "(2,'1','CENTRAL TIGRAY','1970-01-01','0'),"+
      "(20,'3','AWI','1970-01-01','0'),"+
      "(21,'3','OROMIYA','1970-01-01','0'),"+
      "(22,'3','BAHIR DAR SPECIAL','1970-01-01','0'),"+
      "(23,'3','ARGOBA SPECIAL','1970-01-01','0'),"+
      "(24,'4','WEST WELLEGA','1970-01-01','0'),"+
      "(25,'4','EAST WELLEGA','1970-01-01','0'),"+
      "(26,'4','ILU ABA BORA','1970-01-01','0'),"+
      "(27,'4','JIMMA','1970-01-01','0'),"+
      "(28,'4','WEST SHEWA','1970-01-01','0'),"+
      "(29,'4','NORTH SHEWA','1970-01-01','0'),"+
      "(3,'1','EASTERN TIGRAY ','1970-01-01','0'),"+
      "(30,'4','EAST SHEWA','1970-01-01','0'),"+
      "(31,'4','ARSI','1970-01-01','0'),"+
      "(32,'4','WEST HARARGE','1970-01-01','0'),"+
      "(33,'4','EAST HARARGE','1970-01-01','0'),"+
      "(34,'4','BALE','1970-01-01','0'),"+
      "(35,'4','BORENA ','1970-01-01','0'),"+
      "(36,'4','SOUTH WEST SHEWA ','1970-01-01','0'),"+
      "(37,'4','GUJI','1970-01-01','0'),"+
      "(38,'4','ADAMA SPECIAL','1970-01-01','0'),"+
      "(39,'4','JIMMA TOWN SPECIAL','1970-01-01','0'),"+
      "(4,'1','SOUTHERN TIGRAY','1970-01-01','0'),"+
      "(40,'4','WEST ARSI','1970-01-01','0'),"+
      "(41,'4','KELEM WELLEGA ','1970-01-01','0'),"+
      "(42,'4','HORO GUDRU WELLEGA','1970-01-01','0'),"+
      "(43,'4','BURAYU SPECIAL','1970-01-01','0'),"+
      "(44,'8','METEKEL','1970-01-01','0'),"+
      "(45,'8','ASOSA','1970-01-01','0'),"+
      "(46,'8','KAMASHI','1970-01-01','0'),"+
      "(47,'8','PAWE SPECIAL','1970-01-01','0'),"+
      "(48,'8','MAO KOMO SPECIAL','1970-01-01','0'),"+
      "(49,'6','GURAGE','1970-01-01','0'),"+
      "(5,'1','WESTERN TIGRAY','1970-01-01','0'),"+
      "(50,'6','HADIYA','1970-01-01','0'),"+
      "(51,'6','KEMBATA TIBARO','1970-01-01','0'),"+
      "(52,'6','SIDAMA','1970-01-01','0'),"+
      "(53,'6','GEDEO','1970-01-01','0'),"+
      "(54,'6','WOLAYITA','1970-01-01','0'),"+
      "(55,'6','SOUTH OMO','1970-01-01','0'),"+
      "(56,'6','SHEKA','1970-01-01','0'),"+
      "(57,'6','KEFA','1970-01-01','0'),"+
      "(58,'6','GAMO GOFA','1970-01-01','0'),"+
      "(59,'6','BENCH MAJI','1970-01-01','0'),"+
      "(6,'1','MEKELE TOWN SPECIAL','1970-01-01','0'),"+
      "(60,'6','YEM SPECIAL','1970-01-01','0'),"+
      "(61,'6','AMARO SPECIAL','1970-01-01','0'),"+
      "(62,'6','BURJI SPECIAL','1970-01-01','0'),"+
      "(63,'6','KONSO SPECIAL','1970-01-01','0'),"+
      "(64,'6','DERASHE SPECIAL','1970-01-01','0'),"+
      "(65,'6','DAWURO','1970-01-01','0'),"+
      "(66,'6','BASKETO SPECIAL','1970-01-01','0'),"+
      "(67,'6','KONTA SPECIAL','1970-01-01','0'),"+
      "(68,'6','SILTIE','1970-01-01','0'),"+
      "(69,'6','ALABA SPECIAL','1970-01-01','0'),"+
      "(7,'2','ZONE 1','1970-01-01','0'),"+
      "(70,'6','HAWASSA CITY ADMINISTRATION ','1970-01-01','0'),"+
      "(71,'12','AGNEWAK','1970-01-01','0'),"+
      "(72,'12','NUWER','1970-01-01','0'),"+
      "(73,'12','ETANG SPECIAL','1970-01-01','0'),"+
      "(8,'2','ZONE 2','1970-01-01','0'),"+
      "(81,'7','DIRE DAWA','1970-01-01','0'),"+
      "(9,'2','ZONE 3','1970-01-01','0'),"+
      "(454545,'5','liban','1970-01-01','0'),"+
      "(2342,'4','Oromia Zna','1970-01-01','0'),"+
      "(6767,'13','Hareerie','1970-01-01','0'),"+
      "(112134,'5','JIJIGA','1970-01-01','0'),"+
     "(110,'9','Tikildingay','1970-01-01','0');";
  
  final String Insert_Wereda="INSERT INTO Wereda (Id, Subcity_Id,Wereda_Name, Is_Removed) VALUES " +
      "(700,'90','01','0'),"+
      "(701,'90','02','0'),"+
      "(702,'90','03','0'),"+
      "(703,'90','04','0'),"+
      "(704,'90','05','0'),"+
      "(705,'90','06','0'),"+
      "(706,'90','07','0'),"+
      "(707,'90','08','0'),"+
      "(708,'90','09','0'),"+
      "(709,'90','10','0'),"+
      "(710,'90','11','0'),"+
      "(711,'90','12','0'),"+
      "(712,'90','13','0'),"+
      "(713,'91','01','0'),"+
      "(714,'91','02','0'),"+
      "(715,'91','03','0'),"+
      "(716,'91','04','0'),"+
      "(717,'91','05','0'),"+
      "(718,'91','06','0'),"+
      "(719,'91','07','0'),"+
      "(720,'91','08','0'),"+
      "(721,'91','09','0'),"+
      "(722,'91','10','0'),"+
      "(723,'91','11','0'),"+
      "(724,'91','12','0'),"+
      "(725,'91','13','0'),"+
      "(726,'92','01','0'),"+
      "(727,'92','02','0'),"+
      "(728,'92','03','0'),"+
      "(729,'92','04','0'),"+
      "(730,'92','05','0'),"+
      "(731,'92','06','0'),"+
      "(732,'92','07','0'),"+
      "(733,'92','08','0'),"+
      "(734,'92','09','0'),"+
      "(735,'92','10','0'),"+
      "(736,'92','11','0'),"+
      "(737,'92','12','0'),"+
      "(738,'92','13','0'),"+
      "(739,'93','01','0'),"+
      "(740,'93','02','0'),"+
      "(741,'93','03','0'),"+
      "(742,'93','04','0'),"+
      "(743,'93','05','0'),"+
      "(744,'93','06','0'),"+
      "(745,'93','07','0'),"+
      "(746,'93','08','0'),"+
      "(747,'93','09','0'),"+
      "(748,'93','10','0'),"+
      "(749,'93','11','0'),"+
      "(750,'93','12','0'),"+
      "(751,'93','13','0'),"+
      "(800,'94','01','0'),"+
      "(801,'94','02','0'),"+
      "(802,'94','03','0'),"+
      "(803,'94','04','0'),"+
      "(804,'94','05','0'),"+
      "(805,'94','06','0'),"+
      "(806,'94','07','0'),"+
      "(807,'94','08','0'),"+
      "(808,'94','09','0'),"+
      "(809,'94','10','0'),"+
      "(810,'94','11','0'),"+
      "(811,'94','12','0'),"+
      "(812,'94','13','0'),"+
      "(813,'95','01','0'),"+
      "(814,'95','02','0'),"+
      "(815,'95','03','0'),"+
      "(816,'95','04','0'),"+
      "(817,'95','05','0'),"+
      "(818,'95','06','0'),"+
      "(819,'95','07','0'),"+
      "(820,'95','08','0'),"+
      "(821,'95','09','0'),"+
      "(822,'95','10','0'),"+
      "(823,'95','11','0'),"+
      "(824,'95','12','0'),"+
      "(825,'95','13','0'),"+
      "(826,'96','01','0'),"+
      "(827,'96','02','0'),"+
      "(828,'96','03','0'),"+
      "(829,'96','04','0'),"+
      "(830,'96','05','0'),"+
      "(831,'96','06','0'),"+
      "(832,'96','07','0'),"+
      "(833,'96','08','0'),"+
      "(834,'96','09','0'),"+
      "(835,'96','10','0'),"+
      "(836,'96','11','0'),"+
      "(837,'96','12','0'),"+
      "(838,'96','13','0'),"+
      "(839,'97','01','0'),"+
      "(840,'97','02','0'),"+
      "(841,'97','03','0'),"+
      "(842,'97','04','0'),"+
      "(843,'97','05','0'),"+
      "(844,'97','06','0'),"+
      "(845,'97','07','0'),"+
      "(846,'97','08','0'),"+
      "(847,'97','09','0'),"+
      "(848,'97','10','0'),"+
      "(849,'97','11','0'),"+
      "(850,'97','12','0'),"+
      "(851,'97','13','0'),"+
      "(900,'98','01','0'),"+
      "(901,'98','02','0'),"+
      "(902,'98','03','0'),"+
      "(903,'98','04','0'),"+
      "(904,'98','05','0'),"+
      "(905,'98','06','0'),"+
      "(906,'98','07','0'),"+
      "(907,'98','08','0'),"+
      "(908,'98','09','0'),"+
      "(909,'98','10','0'),"+
      "(910,'98','11','0'),"+
      "(911,'98','12','0'),"+
      "(912,'98','13','0'),"+
      "(913,'99','01','0'),"+
      "(914,'99','02','0'),"+
      "(915,'99','03','0'),"+
      "(916,'99','04','0'),"+
      "(917,'99','05','0'),"+
      "(918,'99','06','0'),"+
      "(919,'99','07','0'),"+
      "(920,'99','08','0'),"+
      "(921,'99','09','0'),"+
      "(922,'99','10','0'),"+
      "(923,'99','11','0'),"+
      "(924,'99','12','0'),"+
      "(925,'99','13','0'),"+
      "(1,'1','TAHTAY ADIYABO','0'),"+
      "(10,'2','AHIFEROM','0'),"+
      "(100,'13','FOGERA','0'),"+
      "(101,'13','FARTA','0'),"+
      "(102,'13','LAY GAYINT','0'),"+
      "(103,'13','TACH GAYINT','0'),"+
      "(104,'13','SIMADA','0'),"+
      "(105,'13','MISRAK ESTE','0'),"+
      "(106,'13','DERA','0'),"+
      "(107,'13','DEBRETABOR TOWN','0'),"+
      "(108,'13','MIRAB ESTA','0'),"+
      "(109,'14','BUGNA','0'),"+
      "(11,'2','WERE LEHE','0'),"+
      "(110,'14','KOBO','0'),"+
      "(111,'14','GIDAN','0'),"+
      "(112,'14','MEKET','0'),"+
      "(113,'14','WADLA','0'),"+
      "(114,'14','DELANTA','0'),"+
      "(115,'14','GUBALAFTO','0'),"+
      "(116,'14','HABRU','0'),"+
      "(117,'14','WOLDIYA TOWN','0'),"+
      "(118,'14','LASTA ','0'),"+
      "(119,'14','DAWUNT','0'),"+
      "(12,'2','ADWA','0'),"+
      "(120,'15','MEKDELA','0'),"+
      "(121,'15','TENTA','0'),"+
      "(122,'15','KUTABER','0'),"+
      "(123,'15','AMBASEL','0'),"+
      "(124,'15','TEHULEDERE','0'),"+
      "(125,'15','WEREBABO','0'),"+
      "(126,'15','KALU','0'),"+
      "(127,'15','ALBUKO','0'),"+
      "(128,'15','DESSIE ZURIYA','0'),"+
      "(129,'15','LEGAMBO','0'),"+
      "(13,'2','LAELAY MAYCHEW','0'),"+
      "(130,'15','SAYINT','0'),"+
      "(131,'15','DEBRESINA','0'),"+
      "(132,'15','KELELA','0'),"+
      "(133,'15','JAMA','0'),"+
      "(134,'15','WERE ILU','0'),"+
      "(135,'15','WOGIDI','0'),"+
      "(136,'15','KOMBOLCHA TOWN','0'),"+
      "(137,'15','DESSIE TOWN','0'),"+
      "(138,'15','MEHAL SAYINT','0'),"+
      "(139,'15','LEGAHIDA','0'),"+
      "(14,'2','TAHTAY MAYCHEW     ','0'),"+
      "(140,'16','MIDA WOREMO','0'),"+
      "(141,'16','MERHABETE','0'),"+
      "(142,'16','ENSARO','0'),"+
      "(143,'16','MORETNA JURU','0'),"+
      "(144,'16','MENZ GERA MIDIR','0'),"+
      "(145,'16','GISHE','0'),"+
      "(146,'16','ANTSOKIYANA GEMZA','0'),"+
      "(147,'16','EFRATANA GIDIM','0'),"+
      "(148,'16','MENZ MAMA MIDIR','0'),"+
      "(149,'16','TARMA BER','0'),"+
      "(15,'2','NADER ADET','0'),"+
      "(150,'16','MOJANA WODERA','0'),"+
      "(151,'16','KEWET','0'),"+
      "(152,'16','ANGOLALA TERA','0'),"+
      "(153,'16','ASAGIRT','0'),"+
      "(154,'16','ANKOBER','0'),"+
      "(155,'16','HAGERE MARIAM ','0'),"+
      "(156,'16','BEREHET','0'),"+
      "(157,'16','MINJARNA SHENKORA','0'),"+
      "(158,'16','BASONA WERANA','0'),"+
      "(159,'16','DEBRE BREHAN TOWN','0'),"+
      "(16,'2','KOLA TEMBEN','0'),"+
      "(160,'16','MENZ KEYA GEBREAL','0'),"+
      "(161,'16','MENZ LALO MIDIR','0'),"+
      "(162,'17','BIBUGN ','0'),"+
      "(163,'17','HULET EJ ENESE','0'),"+
      "(164,'17','GONCHA SISO ENESE','0'),"+
      "(165,'17','ENEBSE SAR MIDIR','0'),"+
      "(167,'17','ENARJ ENAWGA','0'),"+
      "(168,'17','ENEMAY','0'),"+
      "(169,'17','DEBAY TILATGIN','0'),"+
      "(17,'2','DEGUA TEMBEN','0'),"+
      "(170,'17','DEBRE ELIAS','0'),"+
      "(171,'17','MACHAKEL','0'),"+
      "(172,'17','GOZAMIN','0'),"+
      "(173,'17','BASO LIBEN','0'),"+
      "(174,'17','DEJEN','0'),"+
      "(175,'17','SHEBEL BERENTA','0'),"+
      "(176,'17','DEBERE MARKOS TOWN','0'),"+
      "(177,'17','SINAN ','0'),"+
      "(178,'17','ANEDED','0'),"+
      "(179,'18','SEMEN ACHEFER','0'),"+
      "(18,'2','TANQUA ABERGELE','0'),"+
      "(180,'18','BAHIR DAR ZURIYA','0'),"+
      "(181,'18','YILMANA DENSA','0'),"+
      "(182,'18','MECHA','0'),"+
      "(183,'18','SEKELA','0'),"+
      "(184,'18','QUARIT','0'),"+
      "(185,'18','DEGA DAMOT','0'),"+
      "(186,'18','DEMBECHA','0'),"+
      "(187,'18','JABI TEHINAN','0'),"+
      "(188,'18','BURE','0'),"+
      "(189,'18','WENBERMA','0'),"+
      "(19,'2','ABIYI ADI TOWN','0'),"+
      "(190,'18','GONJQOLOLA','0'),"+
      "(191,'18','DEBUB ACHEFER','0'),"+
      "(192,'18','FINOTE SELAM TOWN','0'),"+
      "(193,'19','ZIQUALA','0'),"+
      "(194,'19','SEKOTA','0'),"+
      "(195,'19','DEHANA','0'),"+
      "(196,'19','GAZGIBLA','0'),"+
      "(197,'19','ABERGELE','0'),"+
      "(198,'19','SEHALA ','0'),"+
      "(199,'19','SEKOTA TOWN','0'),"+
      "(2,'1','LAELAY ADIYABO','0'),"+
      "(20,'2','ADWA TOWN','0'),"+
      "(200,'20','DANGILA','0'),"+
      "(201,'20','BANJA SHEKUDAD','0'),"+
      "(202,'20','ANKASHA GUAGUSA','0'),"+
      "(203,'20','GUANGUA','0'),"+
      "(204,'20','FAGITA LEKOMA','0'),"+
      "(205,'20','JAWI','0'),"+
      "(206,'20','GUAGUSA SHIKUDA','0'),"+
      "(207,'21','DAWA CHEFA','0'),"+
      "(208,'21','BATI','0'),"+
      "(209,'21','JILE TIMUGA','0'),"+
      "(21,'2','AXUM TOWN','0'),"+
      "(210,'21','ARTUMA FURSI','0'),"+
      "(211,'21','DAWA HAREWA','0'),"+
      "(212,'21','KEMISE TOWN','0'),"+
      "(213,'22','BAHIR DAR TOWN ','0'),"+
      "(214,'23','ARGOBA SPECIAL','0'),"+
      "(215,'24','MENE SIBU','0'),"+
      "(216,'24','NEJO','0'),"+
      "(217,'24','GIMBI','0'),"+
      "(218,'24','LALO ASABI','0'),"+
      "(219,'24','QILTU KARA','0'),"+
      "(22,'3','GULO MEHEDA','0'),"+
      "(220,'24','BOJI DERMEJI','0'),"+
      "(221,'24','GULISO','0'),"+
      "(222,'24','JARSO','0'),"+
      "(223,'24','QONDALA','0'),"+
      "(224,'24','BOJI CHEQORSA','0'),"+
      "(225,'24','BABO GEMBEL','0'),"+
      "(226,'24','YUBDO','0'),"+
      "(227,'24','GENJI','0'),"+
      "(228,'24','HARU','0'),"+
      "(229,'24','NOLE KABA','0'),"+
      "(23,'3','EROB','0'),"+
      "(230,'24','BEGI','0'),"+
      "(231,'24','GIMBI TOWN ','0'),"+
      "(232,'24','SEYO NOLE','0'),"+
      "(233,'24','HOMA','0'),"+
      "(234,'24','AYIRA','0'),"+
      "(235,'25','LIMU','0'),"+
      "(236,'25','EBANTU','0'),"+
      "(237,'25','GIDA KEREMU','0'),"+
      "(238,'25','HARO LIMU','0'),"+
      "(239,'25','BONEYA BUSHE','0'),"+
      "(24,'3','SAESI TSADAMBA','0'),"+
      "(240,'25','WAYU TUQA','0'),"+
      "(241,'25','GUDEYA BILA','0'),"+
      "(242,'25','GOBU SEYO','0'),"+
      "(243,'25','SIBU SIRE','0'),"+
      "(244,'25','DIGA','0'),"+
      "(245,'25','SASIGA','0'),"+
      "(246,'25','LEQA DULECHA','0'),"+
      "(247,'25','GUTO GIDA','0'),"+
      "(248,'25','JIMMA ARJO','0'),"+
      "(249,'25','NUNU QUMBA','0'),"+
      "(25,'3','GANTA AFESHUM','0'),"+
      "(250,'25','WAMA HAGELO','0'),"+
      "(251,'25','NEKEMTE TOWN ','0'),"+
      "(252,'26','DARIMU','0'),"+
      "(253,'26','ALGE SACHI','0'),"+
      "(254,'26','CHORA','0'),"+
      "(255,'26','DIGA','0'),"+
      "(256,'26','DABO HANA','0'),"+
      "(257,'26','GECHI','0'),"+
      "(258,'26','BORECHA','0'),"+
      "(259,'26','DEDESA','0'),"+
      "(26,'3','HAWUZEN','0'),"+
      "(260,'26','YAYU','0'),"+
      "(261,'26','METU ZURIA','0'),"+
      "(262,'26','ALE','0'),"+
      "(263,'26','BURE','0'),"+
      "(264,'26','NONO SELE','0'),"+
      "(265,'26','BECHO','0'),"+
      "(266,'26','BILO NOPHA','0'),"+
      "(267,'26','HURUMU','0'),"+
      "(268,'26','DIDU','0'),"+
      "(269,'26','MAKO','0'),"+
      "(27,'3','KLITE AWLALO','0'),"+
      "(270,'26','HALU','0'),"+
      "(271,'26','METU TOWN ','0'),"+
      "(272,'26','BEDELE TOWN ','0'),"+
      "(273,'26','BEDELE ZURIA','0'),"+
      "(274,'26','CHEWAQA','0'),"+
      "(275,'26','DORENI','0'),"+
      "(276,'27','LIMU SEKA','0'),"+
      "(277,'27','LIMU KOSA','0'),"+
      "(278,'27','SOKORU','0'),"+
      "(279,'27','TIRO AFETA','0'),"+
      "(28,'3','ATSBI WENBERTA','0'),"+
      "(280,'27','KERSA','0'),"+
      "(281,'27','MANA','0'),"+
      "(282,'27','GOMMA','0'),"+
      "(283,'27','GERA','0'),"+
      "(284,'27','SEKA CHEKORSA','0'),"+
      "(285,'27','DEDO','0'),"+
      "(286,'27','OMONADA','0'),"+
      "(287,'27','SIGMO','0'),"+
      "(288,'27','SETEMA','0'),"+
      "(289,'27','SHEBE SENBO','0'),"+
      "(29,'3','ADIGRAT TOWN','0'),"+
      "(290,'27','CHORA BOTER','0'),"+
      "(291,'27','GUMA','0'),"+
      "(292,'28','GINDE BERET','0'),"+
      "(293,'28','JELDU','0'),"+
      "(294,'28','AMBO','0'),"+
      "(295,'28','MIDAKEGNI','0'),"+
      "(296,'28','CHELIA','0'),"+
      "(297,'28','BAKO TIBE','0'),"+
      "(298,'28','DANO','0'),"+
      "(299,'28','NONO','0'),"+
      "(3,'1','MEDEBAY ZANA','0'),"+
      "(30,'3','WUKRO TOWN','0'),"+
      "(300,'28','TIKUR ENCHINI','0'),"+
      "(301,'28','DENDI','0'),"+
      "(302,'28','EJERIE','0'),"+
      "(303,'28','WELMERA','0'),"+
      "(304,'28','ADA A BERGA','0'),"+
      "(305,'28','META ROBI','0'),"+
      "(306,'28','ABUNA GINDEBERET','0'),"+
      "(307,'28','TOKE KUTAYE','0'),"+
      "(308,'28','JIBAT','0'),"+
      "(309,'28','ELIFATA','0'),"+
      "(310,'28','HOLETA TOWN','0'),"+
      "(311,'29','WERE JARSO','0'),"+
      "(312,'29','DERA','0'),"+
      "(313,'29','HIDABU ABOTE','0'),"+
      "(314,'29','KUYU','0'),"+
      "(315,'29','DEGEM','0'),"+
      "(316,'29','GIRAR JARSO','0'),"+
      "(317,'29','DEBRE LIBANOS','0'),"+
      "(318,'29','WUCHALE','0'),"+
      "(319,'29','ABICHUNA GNEA','0'),"+
      "(32,'4','ENDERTA','0'),"+
      "(320,'29','KIMBIBIT','0'),"+
      "(321,'29','BEREH','0'),"+
      "(322,'29','SULULTA','0'),"+
      "(323,'29','FICHE TOWN ','0'),"+
      "(324,'29','YAYA GULELE','0'),"+
      "(325,'29','JIDA','0'),"+
      "(326,'29','MULO','0'),"+
      "(327,'29','ALELTU','0'),"+
      "(328,'29','SENDAFA TOWN ','0'),"+
      "(329,'30','FENTALE','0'),"+
      "(33,'4','HINTALO WAJIRAT','0'),"+
      "(330,'30','BOSET','0'),"+
      "(331,'30','ADAMA','0'),"+
      "(332,'30','LOMME','0'),"+
      "(333,'30','GIMBICHU','0'),"+
      "(334,'30','ADA A','0'),"+
      "(335,'30','DUGDA','0'),"+
      "(336,'30','ADAMI TULU JIDO KOMBOLCHA','0'),"+
      "(337,'30','BISHOFTU TOWN','0'),"+
      "(338,'30','BORA','0'),"+
      "(339,'30','LIBEN','0'),"+
      "(34,'4','ALAJE','0'),"+
      "(340,'30','AKAKI','0'),"+
      "(341,'30','ZEWAY BATU TOWN ','0'),"+
      "(342,'31','MERTI','0'),"+
      "(343,'31','ASEKO','0'),"+
      "(344,'31','GOLOLCHA','0'),"+
      "(345,'31','JEJU','0'),"+
      "(346,'31','DODOTA','0'),"+
      "(347,'31','ZEWAY DUGDA','0'),"+
      "(348,'31','HITOSA','0'),"+
      "(349,'31','SUDE','0'),"+
      "(35,'4','ENDAMEHONI','0'),"+
      "(350,'31','CHOLE','0'),"+
      "(351,'31','AMIGNA','0'),"+
      "(352,'31','SERU','0'),"+
      "(353,'31','ROBE','0'),"+
      "(354,'31','TENA','0'),"+
      "(355,'31','SHIRKA','0'),"+
      "(356,'31','DIGELUNA TIJO','0'),"+
      "(357,'31','TIYO','0'),"+
      "(358,'31','MUNESA','0'),"+
      "(359,'31','LIMUNA BILBILO','0'),"+
      "(36,'4','RAYA AZEBO','0'),"+
      "(360,'31','GUNA','0'),"+
      "(361,'31','SIRE','0'),"+
      "(362,'31','LODE HETOSA','0'),"+
      "(363,'31','DEKSIS','0'),"+
      "(364,'31','BELE GASGAR','0'),"+
      "(365,'31','ENKELO WABE','0'),"+
      "(366,'31','ASELA TOWN ','0'),"+
      "(367,'32','MIESO','0'),"+
      "(368,'32','DOBA','0'),"+
      "(369,'32','TULO','0'),"+
      "(37,'4','ALAMATA','0'),"+
      "(370,'32','MESELA','0'),"+
      "(371,'32','ANCHAR','0'),"+
      "(372,'32','GUBA QORICHA','0'),"+
      "(373,'32','HABRO','0'),"+
      "(374,'32','DARO LEBU','0'),"+
      "(375,'32','BOKE','0'),"+
      "(376,'32','QUNI','0'),"+
      "(377,'32','GEMECHIS','0'),"+
      "(378,'32','BEDESA TOWN ','0'),"+
      "(379,'33','KOMBOLCHA','0'),"+
      "(38,'4','OFLA','0'),"+
      "(380,'33','JARSO','0'),"+
      "(381,'33','GURSUM','0'),"+
      "(382,'33','BABILE','0'),"+
      "(383,'33','FEDIS','0'),"+
      "(384,'33','HAROMAYA','0'),"+
      "(385,'33','KURFA CHELE','0'),"+
      "(386,'33','QERSA','0'),"+
      "(387,'33','META','0'),"+
      "(388,'33','GORO GUTU','0'),"+
      "(389,'33','DEDER','0'),"+
      "(39,'4','MAYCHEW TOWN ','0'),"+
      "(390,'33','MELKA BELO','0'),"+
      "(391,'33','BEDENO','0'),"+
      "(392,'33','CHINAKSEN','0'),"+
      "(393,'33','GIRAWA','0'),"+
      "(394,'33','GOLE ODA','0'),"+
      "(395,'33','MEYU MULEKE','0'),"+
      "(396,'34','AGARFA','0'),"+
      "(397,'34','GOLOLCHA','0'),"+
      "(398,'34','GASERA','0'),"+
      "(399,'34','BELTU','0'),"+
      "(4,'1','TAHTAY QORARO','0'),"+
      "(40,'4','ALAMATA TOWN ','0'),"+
      "(400,'34','GINIR','0'),"+
      "(401,'34','SINANA','0'),"+
      "(402,'34','GOBA','0'),"+
      "(403,'34','ARENA BULUQ','0'),"+
      "(404,'34','DELO MENA','0'),"+
      "(405,'34','MEDA WELABU','0'),"+
      "(406,'34','BERBERE','0'),"+
      "(407,'34','GURA DAMOLE','0'),"+
      "(408,'34','GORO','0'),"+
      "(409,'34','RAYTU','0'),"+
      "(41,'5','KAFTA HUMERA','0'),"+
      "(410,'34','SEWEYNA','0'),"+
      "(411,'34','ROBE TOWN ','0'),"+
      "(412,'34','GOBA TOWN ','0'),"+
      "(413,'34','DAWE QACHEN','0'),"+
      "(414,'34','DINSHO','0');";


       setDatabase() async
   {
     var directory=await getApplicationDocumentsDirectory();
     var path=join(directory.path,'Chinetdb.db');
     var database=await openDatabase(path,version: 1,onCreate: _onCreateDatabase);
     return database;
   }
   _onCreateDatabase(Database database,int version) async{
     await database.execute('''
              CREATE TABLE Vehicles(Vid INTEGER PRIMARY KEY, Vehiclebrand TEXT,ServicetypeId TEXT, Createdate TEXT, Status TEXT,PlateNumber TEXT,  PictureUrl TEXT,  Description TEXT,  VehicleColor TEXT,  ChasisNumber TEXT,  VehicleName TEXT,  Availablity TEXT,lastModifiedDate TEXT,  is_deleted TEXT)
                ''');
     print ("Create Vehicles");
     await database.execute('''
              CREATE TABLE Reasons(ReasonId INTEGER PRIMARY KEY,ReasonName TEXT,Remark TEXT)
                ''');
     print ("Create Reasons");
     await database.execute('''
              CREATE TABLE Routers(
              Id INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT,password TEXT,imei TEXT, isSuccess TEXT,lastModified TEXT,createdAt TEXT, Did TEXT, DropoffAddress TEXT, Dropofflatitude TEXT,Dropofflongitude TEXT,passengerId TEXT,PickupAddress TEXT, Pickuplatitude TEXT,Pickuplongitude TEXT,statusId TEXT, NewRouteId  TEXT,RequestId Text ,FullName Text, Phone TEXT,RouteStatusId TEXT,DriverConfirmTime TEXT,ArrivalTime TEXT, DropOffTime TEXT,ReasonId TEXT, Killometers TEXT, AmountPaid TEXT,  MilesPaid TEXT, IsPaid TEXT, extraRateValue TEXT,extraRateId TEXT,scheduleddate TEXT,scheduledtime TEXT)               
               ''');
     print ("Create Routers");

     await database.execute('''
              CREATE TABLE Service(Sid INTEGER PRIMARY KEY,servicetype TEXT,ratetype TEXT,Roleid TEXT,lastModifiedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create Service");
     await database.execute('''
              CREATE TABLE Currentlocations(CurrentlocationID INTEGER PRIMARY KEY,DriverID TEXT,CurrentlocationLast TEXT,CurrentlocationLon TEXT,CurrentlocationHeading TEXT,CurrentlocationAccuracy TEXT ,CurrentlocationCreatedDate TEXT,lastModifiedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create Currentlocations");
     await database.execute('''
              CREATE TABLE Accounts(Aid INTEGER PRIMARY KEY,name TEXT
              ,	Username TEXT,Email TEXT, 
              	Phone TEXT,AccountType TEXT, 
              	ReferalCodeApplied TEXT,Password TEXT, 
              	RoleID TEXT,Status TEXT, 
              	lastLogin TEXT,otp TEXT, 
              	AccountMiles TEXT,NotificationStatus TEXT,FullName TEXT, 
                lastModifiedDate TEXT)
                ''');
     print ("Create Accounts");

     await database.execute('''
              CREATE TABLE Drivers(Did TEXT,AccountId TEXT,	status TEXT,isOnline TEXT,Balance TEXT,AverageRating TEXT,is_deleted TEXT, lastModifiedDate TEXT)
                ''');
     print ("Create Drivers");
     await database.execute('''
              CREATE TABLE Attachements(Attachementid INTEGER PRIMARY KEY,Name TEXT,Url TEXT,Remark TEXT,lastModifiedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create Attachements");

     await database.execute('''
              CREATE TABLE ContactUs(ContactId INTEGER PRIMARY KEY,PhoneNumbe TEXT,Email TEXT,latitude TEXT,longitude TEXT,Remark TEXT,lastModifiedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create ContactUs");

     await database.execute('''
              CREATE TABLE Notifications(NotificationsId INTEGER PRIMARY KEY,Name TEXT,Detail TEXT ,IsSent TEXT ,IsRead TEXT ,TEXT,lastModifiedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create Notifications");

     await database.execute('''
              CREATE TABLE Passengers(id INTEGER PRIMARY KEY,PassengerId TEXT,AccountId TEXT,lastModifiedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create Passengers");

     await database.execute('''
              CREATE TABLE Roles(RoleID INTEGER PRIMARY KEY,  RoleName TEXT,RoleStatus TEXT,PermissionID TEXT,RolesDeleted TEXT,
              RoleCreated TEXT,RoleCreatedDate TEXT,
              lastModifiedDate Text,isDeleted Text)
                ''');
     print ("Create Roles");


     await database.execute('''
              CREATE TABLE Subcity(Id INTEGER PRIMARY KEY,  Town_Name TEXT,Region_Id TEXT,Sync_Date TEXT,Is_Removed TEXT)
                ''');
     print ("Create Subcity");
     await database.execute('''
              CREATE TABLE Regions(Id INTEGER PRIMARY KEY,  Region_Name TEXT,Sync_Date TEXT,Is_Removed TEXT)
                ''');
     print ("Create Regions");
     await database.execute('''
              CREATE TABLE Wereda(Id INTEGER PRIMARY KEY,  Wereda_Name TEXT,Subcity_Id TEXT,Is_Removed TEXT)
                ''');
     print ("Create Wereda");
     await database.execute('''
              CREATE TABLE rates(Rid INTEGER PRIMARY KEY,ratetypes TEXT,rateWaitingTimePrice,ratePerKilloMeterPrice TEXT,rateNightWaitingTimePrice TEXT,rateFormula TEXT,isDirect TEXT,lastUpdatedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create Rates");
     await database.execute('''
              CREATE TABLE services(Id INTEGER PRIMARY KEY, serviceName TEXT, lastUpdateDate TEXT, isDeleted TEXT)
                ''');
     print ("Create Service");

     await database.execute('''
              CREATE TABLE routeStatuses(Id INTEGER PRIMARY KEY, routeStatusName TEXT, lastUpdatedDate TEXT, isDeleted TEXT)
                ''');
     print ("Create routeStatuses");

     await database.execute('''
              CREATE TABLE vehicleModels(Id INTEGER PRIMARY KEY,  modelName TEXT,brandId TEXT,lastUpdatedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create vehicleModels");

     await database.execute('''
              CREATE TABLE extraRateTypes(Id INTEGER PRIMARY KEY, rateName TEXT, lastUpdateDate TEXT, isDeleted TEXT)
                ''');
     print ("Create extraRateTypes");

     await database.execute('''
              CREATE TABLE extraRates(Id INTEGER PRIMARY KEY,extraRateTypeId TEXT,rateName,rateValue TEXT,isFixed TEXT,formula TEXT,lastUpdatedDate TEXT,isDeleted TEXT)
                ''');
     print ("Create extraRates");
     await database.execute('''
              CREATE TABLE cancelationReasons(Id INTEGER PRIMARY KEY,  reasonName TEXT,reasonDescription TEXT,remark TEXT,isDeleted TEXT,lastModifiedDate TEXT)
                ''');
     print ("Create cancelationReasons");
     await database.execute('''
              CREATE TABLE registerPassenger(AId  INTEGER PRIMARY KEY, userName TEXT,password  TEXT, isSuccess  TEXT,lastModified  TEXT,FullName  TEXT,Phone  TEXT,ReferalCode  TEXT,RoleID  TEXT,StatusId  TEXT,lastLogin  TEXT,otp  TEXT,AccountMiles  TEXT,NotificationStatus  TEXT)
                ''');
     print ("Create registerPassenger");
     database.execute(Insert_Regions);
     database.execute(Insert_Towns);
     database.execute(Insert_Wereda);

   }



}
