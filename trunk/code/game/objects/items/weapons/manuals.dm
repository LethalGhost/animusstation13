/*********************MANUALS (BOOKS)***********************/

/obj/item/weapon/book/manual
	icon = 'library.dmi'
	due_date = 0 // Game time in 1/10th seconds.
	unique = 1   // 0 - Normal book, 1 - Should not be treated as normal book, unable to be copied, unable to be modified.

/obj/item/weapon/book/manual/engineering_construction
	name = "Station Repairs and Construction"
	icon_state ="bookEngineering"
	author = "Concordance Extraction Corporation"	// Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>Station Repairs and Construction</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				body {font-size: 14px;}
				</style>
				</head>
				<body>
				<h2>Конструирование</h2>
				<h3>Особые материалы</h3>
				<h4>Усиленное стекло</h4>
				Требуетс&#1103;: <i>1x Rods, 1x Glass</i>.
				<br>Используйте пруть&#1103; на стекле.
				<h3>Создание полов</h3>
				Требуетс&#1103;: <i>1x Rods, 2x Floor Tiles</i>.
				<br>Используйте пруть&#1103;, наход&#1103;сь в космосе.
				<br>Используйте плитку пола на получившейс&#1103; решётке.
				<br>Используйте плитку пола дл&#1103; создани&#1103; покрыти&#1103;.
				<br>Альтернативный метод: клик на плитке пола, когда вы находитесь в космосе. Пруть&#1103; дл&#1103; этого не нужны.
				<h3>Стены</h3>
				Требуетс&#1103;: <i>4x Metal</i>.
				<br>Щёлкните на металле дл&#1103; открыти&#1103; панели конструкций.
				<br>Выберите ''Build wall girders'' из списка.
				<br>Используйте 2 оставшихс&#1103; листа металла на построенных подпорках.
				<h3>Усиленные стены</h3>
				Требуетс&#1103;: <i>2x Metal, 2x Reinforced Metal</i>.
				<br>Щёлкните на металле дл&#1103; открыти&#1103; панели конструкций.
				<br>Постройте подпорки как в случае с обычной стеной.
				<br>Используйте лист усиленного металла чтобы укрепить подпорки.
				<br>Используйте оставшийс&#1103; лист на подпорках чтобы закончить конструкцию.
				<h3>Решётка</h3>
				Требуетс&#1103;: <i>2x Rods</i>.
				<br>Щёлкните на двух пруть&#1103;х, держа их в руке.
				<h3>Стекл&#1103;нные панели</h3>
				<h4>Одностороннее стекло</h4>
				Требуетс&#1103;: <i>1x Glass, Screwdriver</i>.
				<br>Щёлкните на стекле чтобы открыть панель конструкций.
				<br>Выберите ''One direct''.
				<br>Используйте меню правой кнопки мыши дл&#1103; вращени&#1103;.
				<br>Закрепите отвёрткой.
				<h4>Большое стекло</h4>
				Требуетс&#1103;: <i>2x Glass, Screwdriver</i>.
				<br>Щёлкните на стекле чтобы открыть панель конструкций.
				<br>Выберите ''Full''.
				<br>Используйте отвертку чтобы закрепить стекло.
				<h3>Усиленные стекл&#1103;нные панели</h3>
				<h4>Односторонн&#1103;&#1103; панель</h4>
				Требуетс&#1103;: <i>1x Reinforced Glass, Screwdriver, Crowbar</i>.
				<br>Щелчок на усиленном стекле дл&#1103; открыти&#1103; панели.
				<br>Выберите ''One direct''.
				<br>Правый щелчок дл&#1103; ротации.
				<br>Отвертка.
				<br>Монтировка.
				<br>Отвертка.
				<br>Монтировка.
				<br>Отвертка.
				<h4>Большое стело</h4>
				Требуетс&#1103;: <i>2x Reinforced Glass, Screwdriver, Crowbar</i>.
				<br>Щелчок на усиленном стекле дл&#1103; открыти&#1103; панели.
				<br>Выберите ''Full''.
				<br>Отвертка.
				<br>Монтировка.
				<br>Отвертка.
				<h3>Скрытые двери</h3>
				<h4>Обычные</h4>
				Требуетс&#1103;: <i>4x Metal, Crowbar</i>.
				<br>Щелчок на металле дл&#1103; открыти&#1103; панели конструкций.
				<br>Выберите ''Build wall girders'' из списка.
				<br>Используйте монтировку на подпорках.
				<br>Используйте оставшийс&#1103; металл на смещённых подпорках.
				<h4>Усиленные</h4>
				Требуетс&#1103;: <i>2x Metal, 2x Reinforced Metal, Crowbar</i>.
				<br>Щелчок на металле дл&#1103; открыти&#1103; панели.
				<br>Выберите ''Build wall girders''.
				<br>Используйте монтировку.
				<br>Используйте усиленный металл на смещённых подпорках.
				<h3>APC</h3>
				Требуетс&#1103;: <i>2x Metal, 1x Wire Coil, 1x Circuitboard, 1x Screwdriver, 1x Power Cell, Crowbar</i>.
				<br>Используйте металл дл&#1103; создани&#1103; корпуса APC.
				<br>Используйте корпус на нужной стене.
				<br>Добавьте проводку.
				<br>Вставьте модуль контрол&#1103; питани&#1103;.
				<br>Закрутите электронику отверткой.
				<br>Вставьте батарею.
				<br>Закройте панель монтировкой.
				<h3>Шлюзы</h3>
				Требуетс&#1103;: <i>4x Metal, 1x Reinforced Glass, 1x Wire Coil, 1x Circuitboard, Wrench, Screwdriver</i>.
				<br>Используйте металл дл&#1103; создани&#1103; корпуса двери.
				<br>Закрепите дверь ключом.
				<br><i>Опционально</i>: Добавьте усиленного стекла дл&#1103; стекл&#1103;нной двери.
				<br>Добавьте провода.
				<br>Разблокируйте электронику с помощью ID.
				<br>Выставите уровни доступа.
				<br>Вставьте электронику в корпус.
				<br>Закрутите конструкцию отверткой.
				<h3>Компьютеры</h3>
				Требуетс&#1103;: <i>5x Metal, 2x Glass, 1x Wire Coil, 1x Circuitboard, Wrench, Screwdriver</i>.
				<br>Используйте металл дл&#1103; открыти&#1103; панели конструкций.
				<br>Выберите <i>Computer frame</i>.
				<br>Закрепите гаечным ключом.
				<br>Вставьте плату.
				<br>Закрутите отверткой.
				<br>Вставьте провода.
				<br>Добавьте стекло.
				<br>Закрутите отверткой.
				<h3>Ядро ИИ</h3>
				Требуетс&#1103;: <i>4x Reinforced Metal, 2x Reinforced Glass, 1x Wire Coil, 1x AI Circuitboard, Wrench, Screwdriver</i>. Опционально: <i>Human Brain</i>.
				<br>Постройте корпус из усиленного металла.
				<br>Закрепите гаечным ключом.
				<br>Добавьте материнскую плату.
				<br>Отвертка.
				<br>Провода.
				<br><i>Опционально:</i> Мозг, если Вы создаёте новый ИИ.
				<br>Усиленное стекло.
				<br>Отвертка.
				<h2>Демонтаж</h2>
				<h3>Стены</h3>
				Требуетс&#1103;: <i>Welder, Wrench</i>
				<br>Снимите оболочку сварочным аппаратом.
				<br>Раскрутите подпорки ключом.
				<h3>Усиленные стены</h3>
				Требуетс&#1103;: <i>Welder, Wrench, Screwdriver, Wirecutters, Crowbar</i>.
				<br>Кусачки.
				<br>Отвертка.
				<br>Горелка.
				<br>Монтировка.
				<br>Гаечный ключ.
				<br>Горелка.
				<br>Монтировка.
				<br>Отвертка.
				<br>Кусачки.
				<br>Гаечный ключ.
				<h3>Решётки</h3>
				Требуетс&#1103;: <i>Welder, Wirecutters</i> или <i>Screwdriver</i>.
				<br>Первый метод уничтожает решётку, оставл&#1103;&#1103; 2 прута, второй откручивает, позвол&#1103;&#1103; вытащить и перенести в другое место.
				<br><h3>Стекл&#1103;нные панели</h3>
				<br>Требуетс&#1103;: <i>Welder</i> или <i>Screwdriver</i>.
				<br>Первый метод превращает в лист стекла, второй позвол&#1103;ет перенести в другое место.
				<h3>Усиленные стекл&#1103;нные панели</h3>
				Требуетс&#1103;: <i>Crowbar, Scredriver</i>.
				<br>Отвертка.
				<br>Монтировка.
				<br>Отвертка.
				<br><h3>Скрытые двери</h3>
				<br>Требуетс&#1103;: <i>Screwdriver, Welder, Wrench</i>.
				<br>Использовать в указанном пор&#1103;дке.
				<h3>APC</h3>
				Требуетс&#1103;: <i>Screwdriver, Wirecutters, Crowbar, Welder, Authorised ID</i>.
				<br>Разблокируйте APC соответствующей ID картой.
				<br>Удалите батарейку.
				<br>Раскрутите электронику отверткой.
				<br>Удалите провода кусачками.
				<br>Монтировкой удалите плату.
				<br>Горелкой удалите со стены.
				<br><i>Опционально:</i> Гаечным ключом раскрутите корпус APC.
				<h3>Шлюзы</h3>
				Требуетс&#1103;: <i>Welder, Wrench, Screwdriver, Wirecutters, Crowbar, Multitool</i>.
				<br>Раскрутите дверь отверткой.
				<br>Используйте мультитул чтобы отключить всё, болты должны быть подн&#1103;ты. См. Guide to Hacking.
				<br>Заварите дверь.
				<br>Вытащите электронику монтировкой.
				<br>Удалите проводку кусачками.
				<br>Отсоедините дверь гаечным ключом.
				<br><i>Опционально:</i> Используйте горелку дл&#1103; уничтожени&#1103; корпуса двери.
				<br>Не работает на взломанных E-Mag'ом двер&#1103;х. В этих случа&#1103;х можно использовать RCD.
				<h3>Компьютеры</h3>
				Требуетс&#1103;: <i>Welder, Wrench, Screwdriver, Wirecutters, Crowbar</i>.
				<br>Отвертка.
				<br>Монтировка.
				<br>Кусачки.
				<br>Отвертка.
				<br>Гаечный ключ.
				<br>Горелка.
				</body>
				</html>
		"}

/obj/item/weapon/book/manual/engineering_particle_accelerator
	name = "Particle Accelerator User's Guide"
	icon_state ="bookParticleAccelerator"
	author = "Eli Oldman"				// Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>Particle Accelerator User's Guide</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				</style>
				</head>
				<body>
				<h3>Руководство пользовател&#1103;</h3>
				<h4>Настройка</h4>
				<ol>
					<li>Прикрутите все части <b>гаечным ключом</b> к полу.</li>
					<li>Проведите проводку к каждой части при помощи <b>мотка кабел&#1103;</b>.</li>
					<li>Закрутите все панели при помощи <b>отвертки</b>.</li>
				</ol>
				<h4>Использование</h4>
				<ol>
					<li>Откройте контрольную панель.</li>
					<li>Выставите скорость на 2.</li>
					<li>Начните огонь по генератору сингул&#1103;рности.</li>
					<li><font color='red'><b>Когда сингул&#1103;рность увеличитс&#1103; до таких размеров, что начнёт двигатьс&#1103;, выставите скорость на 0, но не отключайте установку!</b></font></li>
					<li>Оденьте противорадиационный костюм, иначе вы погибните от радиации... Упс, стоило написать это вначале?</li>
				</ol>
				</body>
				</html>
		"}

/obj/item/weapon/book/manual/engineering_hacking
	name = "Hacking"
	icon_state ="bookHacking"
	author = "Concordance Extraction Corporation"	// Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>Hacking</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				body {font-size: 14px;}
				</style>
				</head>
				<body>
				<h2>Необходимые инструменты</h2>
				<ul>
					<li><b>Изолирующие перчатки</b>: В электронике много проводов, которые могут ощутимо ударить током.</li>
					<li><b>Отвёртка</b>: Дл&#1103; вскрыти&#1103; панелей и получени&#1103; доступа к проводке. Об&#1103;зателен.</li>
					<li><b>Кусачки</b>: Дл&#1103; перерезани&#1103; и восстановлени&#1103; проводки. Об&#1103;зателен.</li>
					<li><b>Мультитул</b>: Позвол&#1103;ет закоротить провода. Крайне полезен, но не об&#1103;зателен.</li>
				</ul>
				<h2>Важные объекты взлома</h2>
				<h3>Двери</h3>
				Все двери и шлюзы на станции можно взломать. Цвета и функции проводов распредел&#1103;ютс&#1103; случайным образом в начале каждого раунда, однако если в одном раунде на одной двери за болты отвечает оранжевый провод, он же будет за них отвечать и на всех других на станции. Помните, отключение питани&#1103; двери полностью отключает все другие функции.
				<ol>
					<li>Откройте панель на двери отвёрткой.</li>
					<li>Кликните на двери мультитулом, кусачками или пустой рукой.</li>
					<li>Режьте или закорачивайте провода, пока не найдёте нужный/нужные.</li>
					<ul>
						<li><b>ID сканирование</b>: <i>Импульс</i> мультитула включит красный индикатор запрещённого доступа, <i>перерезанный</i> провод не даст никому использовать дверь.</li>
						<li><b>Контроль ИИ</b>: <i>Импульс</i> будет переключать 'AI control light'; <i>перерезанный</i> провод не даст ИИ контролировать дверь, пока тот не взломает питание двери.</li>
						<li><b>Основное питание</b>: <i>Импульс</i> отключит 'test light' и вырубит питание на 1 минуту; <i>перерезанные</i> провода отключат электричество на 10 секунд, после чего включитс&#1103; резервное питание.</li>
						<li><b>Резервное питание</b>: <i>Импульс</i>, в случае если отключено основное питание, выключит 'test light' и отключит питание на минуту; <i>перерезанный</i> провод, что очевидно, отключит резервное питание.</li>
						<li><b>Контроль болтов</b>: <i>Импульс</i> переключит режим болтов, <i>перерезанный</i> провод опустит болты.</li>
						<li><b>Контроль двери</b>: Бесполезно, если дверь зависит от ID. Если нет, <i>импульс</i> откроет/закроет дверь, <i>перерезанный</i> провод оставит дверь в текущем состо&#1103;нии.</li>
						<li><b>Электрификаци&#1103;</b>: <i>Импульс</i> электрифицирует дверь на 30 секунд; <i>перерезанный</i> провод наэлектризует дверь до тех пор, пока не будет соединён обратно.</li>
					</ul>
					<li>Используйте отвёртку чтобы закрыть панель.</li>
				</ol>
				<h4>Стратегии взлома</h4>
				<ul>
					<li><b>Грубый взлом</b> подразумевает практику на каком-нибудь бесполезном шлюзе, перереза&#1103; все провода, пока вы не обнаружите тот, что отвечает за сброс болтов. Зна&#1103; это, вы можете вскрыть любую дверь с подн&#1103;тыми болтами, перерезав все провода кроме отвечающего за сброс болтов и открыв её монтировкой. Полезно, если у вас нет ммультитула. Бесполезно, если у вас нет перчаток.</li>
					<li><b>Запрещённый доступ</b> подразумевает использование мультитула дл&#1103; того, чтобы закоротить основное питание и открыть дверь монтировкой. Убедитесь что болты подн&#1103;ты, иначе вы минуту будете ждать перед дверью без электричества и с опущенными болтами.</li>
					<li><b>Забаррикадироватьс&#1103;</b> можно опустив болты, перерезав все провода и заварив дверь... Правда это полезно только если у вас единственна&#1103; пара перчаток на всей станции.</li>
					<li><b>Удалённый контроль</b> осуществл&#1103;етс&#1103; подключением удалённого сигнализатора к определённому проводу. Как пример, вы можете удалённо поднимать и опускать болты на двери.</li>
				</ul>
				<h3>APC</h3>
				Используетс&#1103; дл&#1103; контрол&#1103; электричества в одном отсеке. Полезно знать про взлом APC когда ИИ или нерадивые инженеры оставили вас без света. Состо&#1103;ние всех APC доступно через соответствующий терминал контрол&#1103; электропитани&#1103;, так что остерегайтесь злобных старших инженеров.
				<ol>
					<li>Вскройте APC с помощью отвертки.</li>
					<li>Щелкните пустой рукой чтобы получить доступ к проводам.</li>
					<li>Используйте мультитул и кусачки дл&#1103; нахождени&#1103; нужного провода.</li>
					<ul>
						<li><b>Питание (2)</b>: <i>Импульс</i> закоротит питание на APC. Вы должны <i>перерезать и заново соединить</i> провода дл&#1103; восставнолени&#1103; питани&#1103;.</li>
						<li><b>Контроль ИИ</b>: <i>Импульс</i> заставит мигать соответствующий огонёк, <i>перерезанный</i> провод отключит контроль ИИ.</li>
					</ul>
					<li>Закрутите панель отвёрткой.</li>
				</ol>
				<h3>3D принтер</h3>
				Также известен как <i>Autolathe</i>.
				<ol>
					<li>Вскройте отверткой.
					<li>Щёлкните пустой рукой дл&#1103; получени&#1103; доступа к проводке.
					<li>Важных проводов три, <i>перерезание</i> их включает индикаторы посто&#1103;нно, <i>импульс</i> временно (30 секунд). Красный индикатор отвечает за питание, зелёный за электрификацию, синий за доступ к особым предметам.
					<li>Закрутите 3D принтер отверткой.
				</ol>
				<h3>Камеры</h3>
				Камеры, воздушные и пожарные тревоги могут быть включены/отключены при помощи кусачек. Воздушные тревоги не будут сигнализировать о состо&#1103;нии воздуха, пожарные не будут включать тревогу автоматически, а камеры не дадут никому ими пользоватьс&#1103; (включа&#1103; ИИ).
				<h3>MULE бот</h3>
				Взлом MULE ботов - зан&#1103;тие веселое.
				<ol>
					<li>Разблокируйте контроль карточкой Квартирмейстера.</li>
					<li>Раскрутите панель отвёрткой.</li>
					<li>Используйте мультитул и следите за реакцией бота. Подробнее см. на <a href="http://ss13.zlofenix.org/index.php?title=Quartermaster">Викистанции</a>.</li>
					<li>Закрутите панель отверткой.</li>
				</ol>
				<h2>Незначительные объекты взлома</h2>
				Во взломе следующих предметов обычно редко возникает нужда, однако это всё же может пригодитс&#1103;.
				<h3>Радио и сигнализаторы</h3>
				<ol>
					<li>Раскрутите отверткой.</li>
					<li>Откроетс&#1103; панель с доступом к проводам и частотам.</li>
					<li>Проводов всего три, полезны из них лишь два:</li>
					<li><b>Исход&#1103;щий</b> отключает получение передач или сигналов.</li>
					<li><b>Вход&#1103;щий</b> отключает микрофон и передачу сигналов.</li>
				</ol>
				Ма&#1103;чки и стационарные радио также можно взломать подобным образом.
				<h3>Портфели и сейфы</h3>
				<ol>
					<li>Вскройте панель отверткой.</li>
					<li>Используйте мультитул до тех пор, пока не получите сообщение о сбросе пам&#1103;ти.</li>
					<li>Пам&#1103;ть сброшена, введите новый код и нажмите E.</li>
					<li>Закройте панель отверткой.</li>
				</ol>
				<h3>Торговые автоматы</h3>
				<ol>
					<li>Раскрутите отверткой.</li>
					<li>Дл&#1103; вас важны 4 провода:</li>
					<ul>
						<li><b>Ожоги</b>: Поджигает людей, за провод отвечает мигающий индикатор.</li>
						<li><b>Контрбанда</b>: Не делает ничего в перерезанном состо&#1103;нии, импульс открывает доступ к редким товарам.</li>
						<li><b>Доступ</b>: Индикатор того что провод перерезан - желтый диод. Позвол&#1103;ет использовать зависимые от ID автоматы всем.</li>
						<li><b>Электрошок</b>: Электрифицирует автомат, каждый использовавший получает удар током.</li>
					</ul>
					<li>Закрутите обратно.
				</ol>
				</body>
				</html>
		"}

/obj/item/weapon/book/manual/engineering_guide
	name = "Engineering Textbook"
	icon_state ="bookEngineering2"
	author = "Concordance Extraction Corporation"	// Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>Engineering Textbook</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				body {font-size: 14px;}
				</style>
				</head>
				<body>
				<p>Итак, вы инженер, пр&#1103;мо из академии, да? Отлично, это руководство поможет вам в применении ваших навыков на космической станции 13!</p>
				<h2>Достаточно ли &#1103; опытен чтобы стать инженером?</h2>
				<p>Инженерное дело &#1103;вл&#1103;етс&#1103; довольно-таки сложным, однако оно обучит вас основной механике игры. Даже кто-то, способный лишь подн&#1103;ть &#1103;щик с инструментами и достать оттуда отвёртку, достаточно опытен дл&#1103; того, чтобы стать хорошим инженером.</p>
				<h2>Перед тем, как начать</h2>
				<h3>Экипировка инженеров</h3>
				Вот изображени&#1103; предметов, которые всегда должны быть с собой у каждого инженера:
				<p><img src='http://tgstation13.servehttp.com/wiki/images/7/72/Engineers_loadout.png'>
				<p><table cellpadding=3 cellspacing=0 border=1>
				<tr bgcolor='#ddaa77'>
				<td><b>Вид</b></td>
				<td><b>Название</b></td>
				<td><b>Содержимое</b></td>
				<tr bgcolor='#eeccaa' align='center'>
				<td><img src='http://tgstation13.servehttp.com/wiki/images/1/17/Eng_toolbelt.PNG'></td>
				<td><b>Utility belt</b></td>
				<td><img src='http://tgstation13.servehttp.com/wiki/images/e/e2/Toolbelt.png'></td>
				</tr>
				<tr bgcolor='#eeccaa' align='center'>
				<td><img src='http://tgstation13.servehttp.com/wiki/images/e/eb/Eng_backpack.PNG'></td>
				<td><b>Backpack</b></td>
				<td><img src='http://tgstation13.servehttp.com/wiki/images/9/97/Engineers_backpack_contents.png'></td>
				</tr>
				<tr bgcolor='#eeccaa' align='center'>
				<td><img src='http://tgstation13.servehttp.com/wiki/images/f/fc/Eng_box.PNG'></td>
				<td><b>Box</b></td>
				<td><img src='http://tgstation13.servehttp.com/wiki/images/b/b1/Engineers_box_contents.PNG'></td>
				</tr>
				</table>
				<p>Заметьте, что некоторые предметы нужны исключительно дл&#1103; отыгрывани&#1103; роли. Конечно вы можете одеть сварочную маску и бегать в ней по станции, но это не ролеплейно. Также, изредка, вам может пригодитьс&#1103; даже ручка, которую вы часто выбрасываете. Хороший вы инженер или нет определ&#1103;етс&#1103; не только вашими игровыми навыками, но и тем, как вы играете свою роль.</p>
				<h2>Двигатель, солнечные батареи и энерги&#1103;</h2>
				<h3>Выработка энергии</h3>
				<p>Главна&#1103; цель инженеров &mdash; обеспечить станцию электричеством. Дл&#1103; этого вам нужно запустить сингул&#1103;рность. Дл&#1103; детального руководства прочитайте книгу 'Singularity Safety in Special Circumstances'.</p>
				<p>Следующее, о чём вы должны беспокоитс&#1103; &mdash; солнечные батареи. Так как запуск сингул&#1103;рности &mdash; опасный процесс, не стоит оставл&#1103;ть кого-то наедине с не запущенной сингул&#1103;рностью: всем инженерам, включа&#1103; старшего (а лучше под его надзором), желательно запускать сингул&#1103;рность вместе. Когда сингул&#1103;рность запущена, вы можете приступить к настройке солнечных батарей. Дл&#1103; этого вам понадобитьс&#1103; RIG-скафандр, кислородный баллон и маска. Всё это есть в инженерном отсеке. Учтите, что после того, как вы закончили, RIG нужно вернуть. Подробности можно узнать в книге 'Solar Panels on Space Stations' (ещё не издана).</p>
				<h3>Прокладка проводов</h3>
				<p>Если часть станции погружаетс&#1103; во мрак, значит где-то были обрезаны провода. Дл&#1103; осмотра проводки под полом вам понадобитс&#1103; сканер T-Ray. Дл&#1103; того, чтобы резать провода, используйте кусачки, дл&#1103; размещени&#1103; проводов щёлкните на клетке пола, в которой вы хотите разместить провод. Он будет прот&#1103;нут из клетки, в которой вы стоите. Также можно нажимать на "свою" клетку, тогда провода будут проложены по направлению взгл&#1103;да. Дл&#1103; того, чтобы продолжить существующую линию проводки, щёлкните на красной точке (конце провода) из соседней клетки, держа в руке моток кабел&#1103;.</p>
				<p>Прокладывание нескольких проводов на одной клетки заслуживает отдельного упоминани&#1103;. Если у вас есть соединённые провода, идущие с севера на юг, и половина провода, проложенного из клетки на восток, они не будут соединены (красна&#1103; точка символизирует что в этом месте лишь конец провода, а не соединение). Дл&#1103; того, чтобы соединить все три провода, вам нужно кусачками удалить соединённые провода, заменить их двум&#1103; полу-проводами. После того, как провода размещены, правый щелчок с катушкой в руке по клетке создаст соединение трёх проводов (да и выгл&#1103;деть оно будет симпатично). Звучит сложно, просто поэкспериментируйте.</p>
<!--				<h3>Отслеживание и распределение энергии</h3>
				an APC or Area Power Controller is located in every room. It is usually locked, but you can unlock it by swiping your ID on it. It contains a power cell. You can shut off a room's power or disable or enable lighting, equipment or atmospheric systems with it. Every room can have only one APC. The guide to their construction and deconstruction can be found in the book entitled 'Station repairs and construction'. APC's can also be hacked (More on that in the book entitled 'Hacking'). It's also a good idea to know how to do that. DO NOT PRACTICE ON THE ENGINE APCs! If you mess up, you can destroy it through hacking which can set the singularity free if you do it in engineering! You know this warning is here because it happened before.
-->
				<h2>Поддержание целостности станции</h2>
				<p>Или, иначе говор&#1103;, ремонт. Дл&#1103; этого смотрите книгу 'Station epairs and construction'.</p>
<!--				<p>An educated word which basically means wall repairs.</p>
				<h3> The secrets surrounding walls </h3>
				<p>Walls come in two forms: Regular and reinforced. Building a regular wall is a two step process: constructing girders and adding plating. To construct a girder have a stack of two or more sheets of metal on you (right click the metal and examine it to see how many sheets are in the stack). Left click the metal for a construction window to appear. choose "Construct wall girders" from the list and wait a few seconds while they're built. Once they're built, click on the girders with another stack of two or more metal to add the plating. Note that only fully built walls will prevent air from escaping freely through them. Reinforced walls share the first step: the building of the girders. after this, you'll need 4 sheets of metal. In the same way as you built the girders, create two reinforced sheets. Use one of them on the girders to create reinforced girders and the other on the reinforced girders to finalize them. Reinforced walls are much stronger than regular walls and take much longer to get through using regular tools.</p>
				<p>For more on construction read the book entitled 'Station Repairs and Construction'.</p>
				<h3> Pretty glass </h3>
				<p>Notice how most of the glass around the station is built as a double pane, which surrounds a grille. Making this by hand can be a bit tricky at first, but is simple once you get the hang of it. To build such a wall, you'll need 4 sheets of glass and 3 sheets of metal, alternatively you can have 6 sets of rods. You'll also need a screwdriver and crowbar, tho having wirecutters and a welder with you is a good idea, as you'll likely get it wrong the first time and will need those to dismantle the grille. First you have to prepare your materials. Use the metal on itself and create 6 sets of rods (2 are made each time). Now pick the rods up (you can stack them, but don't click too quickly or the game might think you wanted to build a grille). After this, use 4 of the rods on 4 sheets of glass to create 4 sheets of reinforced glass. Now pick up all your tools (put them on your utility belt if you have one or in your backpack) and pick up the remaining two rods in one hand and the 4 sheets of reinforced glass in your other (remember, you can stack glass too). Now stand where you'd like the glass to be. Use the rods on themselves and this will create a grille. DO NOT MOVE! Now use the glass on itself 4 times and create a single paned glass every time. Right click on the glass to rotate it until you have 3 of the 4 sides covered. The remaining side is your escape route. use the combination of screwdriver - crowbar - screwdriver on each of the 3 panes which are already in place to secure them. Now move out of the grille and rotate the last window so it covers the last side. Fasten that with the same screwdriver - crowbar - screwdriver combination. Congratulations. You've just made a proper window. You're already better at construction than most.</p>
				<p>For more on construction read the book entitled 'Station Repairs and Construction'.</p>
				<h2>Роботы, ИИ и компьютеры</h2>
				<p>As an engineer, it is required of you to understand how most computers are operated, how they work, how they're created, dismantled and repaired. You're also the best equipped station employee to prevent the AI from taking a life of it's own.</p>
				<h3>Компьютеры</h3>
				<p>Computers are everywhere on SS13. Engineering has a power monitoring computer, several solar computers and a general alerts computer. Almost everything you can control is done through a computer. Making them is described in the book entitled 'Station Repairs and Construction', as is their dissasembly (for those which can be deconstructed). To learn how to operate different computer you'll need to start using them and find out how they work while doing so. There are too many to explain them all here.</p>
				<h3>Искусственный идиот</h3>
				<p>More often than not, the AI will be rogue. This means it has laws which are harmful. It will try it's best to kill any crew members by flooding the halls with toxic plasma, sparking fires, overloading APC's, electrifying doors, etc. At such a time you have two choices: Destroy it or reset it. As said, the AI works on a principle of laws. People can upload new ones to it and if these are harmful, you'll first want to try to reset it. In technical storage (in the maintenance hallway between assistant's storage and EVA) you have an AI upload card and an AI reset module. To reset the AI, first create an AI upload computer and once it is created, click on it to choose the rogue AI and use the module on it to reset it. If the person has uploaded a core law, then it's a bit harder. A core law cannot be reset with the AI reset module. You'll need to override it with another AI core module. These can be found in the AI upload area under lock and key. But if the person who uploaded the traitorous law got in, you can get in too, right? The often preferred alternative is to simply kill the AI. Tear down the walls and shoot it, blow it up, use the chemist to prepare something. There are many ways of doing this. Note that if hostile runtimes are reported, you'll have to get to the AI satellite, as the rogue AI is there.</p>
				<p>Blowing up cyborgs is normally done by the roboticist or Research Director, but you may need to help them create a robotics console at some point. One of these can be found in tech storage, but is usually stolen quickly.</p>
				<p>The alternative methods to being helpful included hacking APCs and doors, usually to disable the AI control. This is especially important anywhere near a robotics control, engine, or any of the SMES rooms. The AI has no reason to have control over these anyway.</p>
-->
				<h2>Работа спасател&#1103;</h2>
				<p>Да, это тоже часть вашей работы. Да, вы выполн&#1103;ете абсолютно все функции на станции. Гордитесь этим.</p>
				<h3>Тушение пожаров</h3>
				<p>У инженеров есть доступ в туннели, где есть пожарные костюмы и огнетушители. Если где-то пожар &mdash; тушите. Пожарные костюмы позвол&#1103;ют вам находитьс&#1103; в полыхающем коридоре/туннеле/отсеке. Огнетушители быстро опустошаютс&#1103;, наполн&#1103;йте их при помощи больших баков с водой (<i>water tank</i>).</p>
				<h3>Из-под завалов</h3>
				<p>Если кто-то кричит в радио о том, что он не может выйти из отсека &mdash; это снова ваша работа. Взламывайте двери, деконструируйте стены, но вытащите людей. Это ваша об&#1103;занность.</p>
<!--				<h3> Space recovery </h3>
				<p>A body's been spaced? Well now it's your job to recover it. Ask the AI or captain to get a jetpack and space suit from EVA and go after the body. You'll most frequently find bodies either somewhere near the derelict or the AI satellite. Drag them to a teleporter and get them back to the station. The use of lockers will help greatly, as lockers do not drift like bodies do, but cannot travel across Z-levels. ALWAYS have tools, glass and metal with you when doing this! Some teleporters need to be rebuilt and some bodies float around randomly and need floor tiles to be build in their path to actually stop.</p>
-->
				<h2>Исседование космоса</h2>
				<p>Исследование космоса можт быть интересным, даже не смотр&#1103; на то, что в данный момент в космосе не так и много всего. Вы можете найти некоторые полезные вещички... Вот только с возвращением наверн&#1103;ка возникнут проблемы.
				</body>
				</html>
		"}

/obj/item/weapon/book/manual/engineering_singularity_safety
	name = "Singularity Safety in Special Circumstances"
	icon_state ="bookEngineeringSingularitySafety"
	author = "Concordance Extraction Corporation"	// Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>Singularity Safety in Special Circumstances</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				body {font-size: 14px;}
				</style>
				</head>
				<body>
				<h3>Безопасность при работе с сингул&#1103;рностью в экстренных ситуаци&#1103;х</h3>
				<h4>Нет электричества</h4>
				<p>Вс&#1103; станци&#1103; в один момент потер&#1103;ла электричество? Веро&#1103;тно, это неизвестные технологии Синдиката, хот&#1103; инженерам всегда проще свалить свою ошибку на этот самый Синдикат.</p>
				<p><b>Шаг 1:</b> <b><font color='red'>ПАНИКУЙТЕ!</font></b><br>
				<b>Шаг 2:</b> Бегите в инженерный отсек! <b>Быстро!!!</b><br>
				<b>Шаг 3:</b> Доберитесь до APC, который контролирует эмиттеры.<br>
				<b>Шаг 4:</b> Разблокируйте APC вашей ID-картой. Если не получаетс&#1103; - перейдите к шагу 15.<br>
				<b>Шаг 5:</b> Откройте консоль и снимите замок кожуха.<br>
				<b>Шаг 6:</b> Откройте APC при помощи монтировки.<br>
				<b>Шаг 7:</b> Достаньте пустую батарею.<br>
				<b>Шаг 8:</b> Поместите полностью зар&#1103;женную батарею в APC, если такой не имеетс&#1103; переходите к шагу 15.<br>
				<b>Шаг 9:</b> Быстро наденьте радиационный костюм.<br>
				<b>Шаг 10:</b> Проверьте генераторы пол&#1103; &mdash; если они уже не работают, переходите к шагу 15.<br>
				<b>Шаг 11:</b> Если что-то выт&#1103;гивает из станции энергию &mdash; отключите APC от сети, перерезав ведущий к остальным коммуникаци&#1103;м провод. Если же электричество отключилось по вашей вине &mdash; переходите к шагу 14.<br>
				<b>Шаг 12:</b> Вскройте ближайший к APC тайл пола.<br>
				<b>Шаг 13:</b> Используйте кусачки на проводе, ведущем в сторону терминала.<br>
				<b>Шаг 14:</b> Отправл&#1103;йтесь в бар и расскажите при&#1103;тел&#1103;м как вы их всех спасли. Закончите чтение на этом пункте.<br>
				<b>Шаг 15:</b> <b>УБИРАЙТЕСЬ К ЧЁРТОВОЙ МАТЕРИ ОТТУДА!</b><br></p>
				<h4>Повреждение щитов</h4>
				<b>Шаг 1:</b> <b>УБИРАЙТЕСЬ ОТТУДА! ЗАБУДЬТЕ ПРО ЖЕНЩИН И ДЕТЕЙ, СПАСАЙТЕ СЕБЯ!</b><br>
				</body>
				</html>
		"}



/obj/item/weapon/book/manual/medical_cloning
	name = "Cloning techniques of the 26th century"
	icon_state ="bookCloning"
	author = "Medical Journal, volume 3"		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>Cloning techniques of the 26th century</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				body {font-size: 14px;}
				</style>
				</head>
				<body>
				<h3>Как клонировать людей</h3>
				<p>Итак, на полу лежит 50 трупов, повсюду верт&#1103;тс&#1103; стуль&#1103; и вы не представл&#1103;ете что нужно делать? Всё в пор&#1103;дке! Это руководство научит вас технологи&#1103;м клонировани&#1103; шаг за шагом! Если же что-то в этом руководстве вам непон&#1103;тно, веро&#1103;тно, генетика &mdash; это не ваше, помен&#1103;йте профессию, пока вас не засудили за профессиональную некомпетентность.</p>
				<ol>
					<li><a href='#1'>Подготовьте тело</a></li>
					<li><a href='#2'>Снимите с трупа всю одежду</a></li>
					<li><a href='#3'>Поместите тело в аппарат дл&#1103; клонировани&#1103;</a></li>
					<li><a href='#4'>Просканируйте тело</a></li>
					<li><a href='#5'>Клонируйте</a></li>
					<li><a href='#6'>Подготовьте чистые структурные энзимы</a></li>
					<li><a href='#7'>Поместите тело в морг</a></li>
					<li><a href='#8'>Дождитесь окончани&#1103; клонировани&#1103;</a></li>
					<li><a href='#9'>Введите чистые энзимы</a></li>
					<li><a href='#10'>Верните одежду и вещи</a></li>
					<li><a href='#11'>Выпустите клонированного из отсека</a></li>
				</ol>
				<a name='1'><h4>Шаг 1: Подготовьте тело</h4></a>
				<p>Это довольно-таки важный пункт, ведь без тела вы не можете начать процесс клонировани&#1103;. Обычно тела будут приносить к вам, так что об этом пункте вам беспокоитьс&#1103; не нужно. Если тело у вас уже есть &mdash; отлично, переходите к новому пункту.</p>
				<a name='2'><h4>Шаг 2: Снимите с трупа всю одежду</h4><a/>
				<p>Аппарат клонировани&#1103; не принимает любые абиотические предметы. Так что вы не можете клонировать человека в одежде, снимите её. Если тело всего одно &mdash; неплохо бы поместить вещи клонируемого в шкаф. Если же вокруг вас 7 трупов, просто оставл&#1103;йте их вещи на месте, не перемешива&#1103; между собой. И ради всего св&#1103;того, не дайте клоуну стащить чужие вещи!</p>
				<a name='3'><h4>Шаг 3: Поместите тело в аппарат дл&#1103; клонировани&#1103;</h4><a/>
				<p>Схватите тело и поместите его в модификатор ДНК. Если не получаетс&#1103; - значит что-то не так с пунктом 2, проверьте что вы сн&#1103;ли абсолютно ВСЕ предметы с объекта.</p>
				<a name='4'><h4>Шаг 4: Просканируйте тело</h4><a/>
				<p>Зайдите в консоль и просканируйте тело, нажав на кнопку <i>Scan</i>. Если всё успешно, объект добавитс&#1103; в базу данных (стоит заметить, что клонировать из базы данных можно когда угодно и тело дл&#1103; этого не требуетс&#1103;, клонируемый объект может быть хоть в глубоком космосе с выключенными сенсорами). В противном случае по&#1103;витс&#1103; ошибка ментального интерфейса: <i>Error: Mental interface failure</i>. Это значит что сознание клонируемого летает где-то в виде призрака. В таком случае просто крикните им вернутьс&#1103; в тело (не в радио, призраки услышат и негромкий зов), обновите интерфейс и попробуйте снова просканировать. Безуспешно? Скажите что отдадите труп повару, если призрак не вернётс&#1103; в тело. Всё ещё не помогло? Перейдите к пункту 7 и закончите на нём. Тело нельз&#1103; клонировать. Если вы получите ошибку <i>Error: Unable to locate valid genetic data</i>, значит вы пытаетесь клонировать обезь&#1103;ну, что &#1103;вл&#1103;етс&#1103; безуспешной затеей.</p>
				<a name='5'><h4>Шаг 5: Клонируйте</h4><a/>
				<p>После того, как объект занесён в базу данных, выберите <i>View Records</i>, щёлкните на имени объекта, затем на кнопке <i>Clone</i>. Поздравл&#1103;ем! Половина пути пройдена. Помните, не извлекайте тело из камеры клонировани&#1103; до окончани&#1103; процесса клонировани&#1103;, это убьёт клона и вам придётс&#1103; начинать процесс с начала.</p>
				<a name='6'><h4>Шаг 6: Подготовьте чистые структурные энзимы</h4><a/>
				<p>Клонирование &mdash; процесс тонкий и привередливый. Вернувшиес&#1103; с того света и восставшие из мёртвых будут иметь пару непри&#1103;тных генетических дефектов, полученных в процессе клонировани&#1103;! Дл&#1103; этого вам нужно приготовить чистых структурных энзимов, которые вы вколите по завершению процесса клонировани&#1103;. Если вы хороший генетик &mdash; образец чистых энзимов уже есть в вашей консоли. Если нет, извлеките тело из модификатора ДНК (и ни в коем случае не из камеры клонировани&#1103;) и поместите его в модификатор в вашей лаборатории. Перейдите во вкладку <i>View/Edit/Transfer Buffer</i>, найдите чистый слот, выберите <i>SE</i> дл&#1103; их сохранени&#1103;. Затем щёлкните на <i>Injector</i>. Поместите полученные шприц в карман до завершени&#1103; процедуры клонировани&#1103;.</p>
				<a name='7'><h4>Шаг 7: Поместите тело в морг</h4><a/>
				<p>Теперь, когда инициирован процесс клонировани&#1103; и у вас есть чистые структурные энзимы, вы больше не нуждаетесь в теле. Отнесите тело в морг и скажите по радио повару, что там его дожидаетс&#1103; свежее м&#1103;со. Просто откройте трей, поместите туда тело и закройте его. Можно пометить ручкой как <i>Chef meat</i> дл&#1103; избежани&#1103; конфузов.</p>
				<a name='8'><h4>Шаг 8: Дождитесь окончани&#1103; клонировани&#1103;</h4><a/>
				<p>Теперь возвращайтесь в лабораторию и дождитесь окончани&#1103; процесса клонировани&#1103;. Это будет недолго, честно.</p>
				<a name='9'><h4>Шаг 9: Введите чистые энзимы</h4><a/>
				<p>Процесс клонировани&#1103; завершён? Отлично! Возьмите шприц и вколите чистых энзимов новому клону. Вскоре про&#1103;вившиес&#1103; дефекты исчезнут.</p>
				<a name='10'><h4>Шаг 10: Верните одежду и вещи</h4><a/>
				<p>Что очевидно, клон будет раздет. Если вы ответственный генетик, то вы сохранили их вещи от воров и можете вернуть их пациенту. Независимо от вашей жестокости, выпускать пациентов без вещей &mdash; против протокола.</p>
				<a name='11'><h4>Шаг 11: Выпустите клонированного из отсека</h4><a/>
				<p>Проведите последнюю проверку, убедитесь что у клона нет дефектов и они забрали все свои вещи. Выведите клона из генетики и медицинского отсека.</p>
				<p>Если вы добрались досюда, примите наши поздравлени&#1103;! Вы освоили искусство клонировани&#1103;. Теперь главна&#1103; проблема &mdash; не быть убитым агентом Синдиката за то, что вы клонировали его цель.</p>
				</body>
				</html>
		"}

/obj/item/weapon/book/manual/ripley_build_and_repair
	name = "APLU \"Ripley\" Construction and Operation Manual"
	icon_state ="book"
	author = "Weyland-Yutani Corp"			// Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>APLU "Ripley" Construction and Operation Manual</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				body {font-size: 14px;}
				</style>
				</head>
				<body>
				<center>
				<b style='font-size: 12px;'>Weyland-Yutani - Building Better Worlds</b>
				<h1>Autonomous Power Loader Unit \"Ripley\"</h1>
				</center>
				<h2>Спецификаци&#1103;:</h2>
				<ul>
				<li><b>Класс:</b> Автоматический грузовой механизм</li>
				<li><b>Область:</b> Логистика и конструирование</li>
				<li><b>Вес:</b> 820 кг (без оператора и груза)</li>
				<li><b>Высота:</b> 2.5 м</li>
				<li><b>Ширина:</b> 1.8 м</li>
				<li><b>Максимальна&#1103; скорость</b> 5 км/час</li>
				<li><b>Функционирование в вакууме/враждебной среде:</b> Допустимо</b>
				<li><b>Вместимость воздушных баллонов:</b> 500 литров</li>
				<li><b>Устройства:</b>
					<ul>
					<li>Гидравлический подъёмник</li>
					<li>Высокоскоростна&#1103; дрель</li>
					</ul>
				</li>
				<li><b>Привод:</b> Электрогидравлическа&#1103; система с питанием от батарей.</li>
				<li><b>Зар&#1103;д батарей:</b> Варьируетс&#1103;.</li>
				</ul>

				<h2>Конструкци&#1103;:</h2>
				<ol>
				<li>Присоедините все части механизма к корпусу.</li>
				<li>Закрепите все гидравлические соединени&#1103; гаечным ключом.</li>
				<li>Настройте гидравлику сервоприводов с помощью отвёртки.</li>
				<li>Проведите провода (кабели не включены).</li>
				<li>Используйте кусачки дл&#1103; удалени&#1103; остатков проводов.</li>
				<li>Установите центральный контрольный модуль.</li>
				<li>Закрепите модуль отвёрткой.</li>
				<li>Установите модуль контрол&#1103; периферии.</li>
				<li>Закрепите модуль отвёрткой.</li>
				<li>Прикрепите слой внутренней брони (может быть изготовлено из 5 листов металла).</li>
				<li>Закрепите слой брони гаечным ключом.</li>
				<li>Приварите слой внутренней брони горелкой.</li>
				<li>Прикрепите слой внешней брони (может быть изготовлено из 5 укреплённых листов металла).</li>
				<li>Закрепите слой брони гаечным ключом.</li>
				<li>Приварите слой внешней брони горелкой.</li>
				</ol>
				</body>
				</html>
		"}

/obj/item/weapon/book/manual/research_and_development
	name = "Research and Development 101"
	icon_state = "rdbook"
	author = "Doctor Emmet Lathrop Brown"		// Who wrote the thing, can be changed by pen or PC. It is not automatically assigned.

// Big pile of shit below.

	dat = {"<html>
				<head>
				<title>Research and Development 101</title>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px; font-size: 10px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				p {font-size: 14px;}
				body {font-size: 14px;}
				</style>
				</head>
				<body>
				<h1>Наука дл&#1103; чайников</h1>
				<p>Итак, ваш выбор &mdash; наука? Отличное решение! Научные исследовани&#1103; &mdash; процесс со множеством тонкостей, однако лёгкий в освоении. В большинстве случаев вам достаточно простой инструкции:</p>
				<ol>
					<li>Деконструируйте предметы в деструктивном анализаторе <i>(Destructive Analyzer)</i> дл&#1103; улучшени&#1103; технологий.</li>
					<li>Создавайте разблокированные прототипы в протолате <i>(Protolathe)</i> и платопечатной установке <i>(Circuit Imprinter)</i>.</li>
					<li>Повтор&#1103;йте N раз!</li>
				</ol>
				<p>Эти простые шаги позвол&#1103;т вам начать путь в завораживающий мир науки... А теперь по говорим о средствах, с помощью которых вы и станете известным учёным.</p>
				<h2>Консоль R&D</h2>
				<p>Консоль R&D &mdash; краеугольный камень любой лаборатории. Это центральна&#1103; система, при помощи которой контролируетс&#1103; деструктивный анализатор, протолат и платопечатна&#1103; установка. Также консоль работает как база данных всех исследованных устройств и технологий. Пока консоль цела&#1103; &mdash; все технологии остаютс&#1103; сохранены. Защищайте её, ведь в случае повреждени&#1103; вы потер&#1103;ете все данные! Дл&#1103; сохранени&#1103; информации есть возможность записи базы на диски, а также восстановлени&#1103; баз с диска. В консоли предусмотрена опци&#1103; ресихронизации с наход&#1103;щимис&#1103; в пределах дос&#1103;гаемости устройствами дл&#1103; исследований (если они по какой-либо причине были отсоединены), а также возможность блокировать консоль, загружать данные в сеть (все R&D консоли по умолчанию объединены в сеть), подключатьтс&#1103; или отключатьс&#1103; от сети, удал&#1103;ть все данные исследований.</p>
				<p><b>Заметка:</b> Список технологий, а также мен&#1103; платопечатного устройства и протолата доступны пользовател&#1103;м без ID учёного. Это сделана дл&#1103; возможности размещени&#1103; 'публичных' систем дл&#1103; обеспечени&#1103; станции новыми технологи&#1103;ми.</p>
				<h2>Деструктивный анализатор</h2>
				<p>Источник всей технологии. Когда вы помещаете предмет в анализатор, он определ&#1103;ет все технологические достижени&#1103;, которые можно извлечь из предмета. Если технологи&#1103;, использующа&#1103;с&#1103; в объекте, так же или более развита по отношению к текущему уровню знаний, вы можете уничтожить объкет дл&#1103; продвижени&#1103; исследований. Изначально некоторые устройства (в большинстве своём созданные при помощи протолата или платопечатной установки) не &#1103;вл&#1103;ютс&#1103; надёжными на 100%. Если устройство сломаетс&#1103; &mdash; вы сможете поместить его в деструктивный анализатор дл&#1103; повышени&#1103; знаний о технологии. Если же надёжность находитс&#1103; на должном уровне, повторное исследование объекта также увеличит смежные технологии.</p>
				<h2>Платопечатна&#1103; установка</h2>
				<p>Это устройство, как и протолат, используетс&#1103; дл&#1103; фактического создани&#1103; новых устройств. Установке требуетс&#1103; стекло и различные химикаты дл&#1103; создани&#1103; новых плат, требуемых дл&#1103; постройки новых механизмов и компьютеров. Это устройство может быть использовано и дл&#1103; печати плат ИИ.</p>
				<h2>Протолат</h2>
				<p>Это устройство &mdash; улучшенна&#1103; верси&#1103; автолата. В отличии от автолата, протолат дл&#1103; создани&#1103; предметов перерабатывает такие материалы, как металл, стекло, твёрда&#1103; плазма, серебро, золото, алмазы и большое разнообразие различных химикатов. Обратна&#1103; сторона медали &mdash; предметы, созданные в протолате, не надёжны на 100%.</p>
				<h1>Надёжность и вы</h1>
				<p>Как уже было дважды сказано, устройства при их открытии надёжны далеко не полностью. Взамен, надёжность устройства зависит не от уровн&#1103; развити&#1103; технологий или усовершенствований. Дл&#1103; улучшени&#1103; надёжности, вам необходимо использовать объект до тех пор, пока он не сломаетс&#1103;. Затем вы сможете проанализировать его в деструктивном анализаторе. После того, как порог надёжности подниметс&#1103; выше определённого значени&#1103;, вы получите некие дополнительные преимущества в технологии.</p>
				<h1>Усовершенствование механизмов</h1>
				<p>Многие механизмы, собранные с использованием плат, требуют большое количество составных частей, вроде конденсаторов, батарей и прочего. Чем выше уровень развити&#1103; технологий, тем более продвинутые версии составл&#1103;ющих вам доступны. Использование усовершенствованных составл&#1103;ющих при сборке позвол&#1103;ет улучшить характеристики конечного устройства. Например, если при сборке автолата вы используете усовершенствованное хранилище материалов заместо стандартного, повыситс&#1103; вместимость автолата. Экспериментируйте с част&#1103;ми, однако помните про низкую надёжность экспериментальных составл&#1103;ющих. Ненадёжна&#1103; часть механизма со временем выведет из стро&#1103; весь механизм.</p>
				</body>
				</html>
		"}