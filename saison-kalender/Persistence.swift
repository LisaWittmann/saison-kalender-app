//
//  Persistence.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import CoreData

struct PersistenceController {
    static var shared: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        
        seed(in: viewContext)
    
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        seed(in: viewContext)
    
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "saison_kalender")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    static func seed(in context: NSManagedObjectContext) {
        let apfel = Seasonal.create(name: "Apfel", seasons: [.August, .September, .October], in: context)
        let aprikose = Seasonal.create(name: "Aprikose", seasons: [.July, .August], in: context)
        let artischocke = Seasonal.create(name: "Artischocke", seasons: [.July, .August, .September], in: context)
        let aubergine = Seasonal.create(name: "Aubergine", seasons: [.June, .July, .August, .September, .October], in: context)
        let birne = Seasonal.create(name: "Birne", seasons: [.July, .August, .September, .October], in: context)
        let blumenkohl = Seasonal.create(name: "Blumenkohl", seasons: [.May, .June, .July, .August, .September, .October, .November], in: context)
        let brokkoli = Seasonal.create(name: "Brokkoli", seasons: [.June, .July, .August, .September, .October, .November], in: context)
        let brombeere = Seasonal.create(name: "Brombeere", seasons: [.July, .August, .September], in: context)
        let butternut = Seasonal.create(name: "Butternut Kürbis", seasons: [.September, .October], in: context)
        let champignons = Seasonal.create(name: "Champignons", seasons: [.January, .February, .March, .April, .May, .June, .July, .August, .September, .October, .November, .December], in: context)
        let chinakohl = Seasonal.create(name: "Chinakohl", seasons: [.January, .February, .March, .April, .May, .June, .July, .August, .September, .October, .November, .December], in: context)
        let eisbergsalat = Seasonal.create(name: "Eisbergsalat", seasons: [.May, .June, .July, .August, .September, .October], in: context)
        let endiviensalat = Seasonal.create(name: "Endiviensalat", seasons: [.May, .June, .July, .August, .September, .October, .November], in: context)
        let erbsen = Seasonal.create(name: "Erbsen", seasons: [.June, .July, .August], in: context)
        let erbeere = Seasonal.create(name: "Erdbeere", seasons: [.May, .June, .July], in: context)
        let feldsalat = Seasonal.create(name: "Feldsalat", seasons: [.January, .February, .March, .October, .November, .December], in: context)
        let fenchel = Seasonal.create(name: "Fenchel", seasons: [.June, .July, .August, .September, .October], in: context)
        let fruehlingszwiebel = Seasonal.create(name: "Frühlingszwiebel", seasons: [.May, .June, .July, .August, .September, .October], in: context)
        let gruenkohl = Seasonal.create(name: "Grünkohl", seasons: [.January, .October, .November, .December], in: context)
        let heidelbeere = Seasonal.create(name: "Heidelbeere", seasons: [.June, .July, .August, .September], in: context)
        let hokkaido = Seasonal.create(name: "Hokkaido", seasons: [.August, .September, .October], in: context)
        let holunderbeere = Seasonal.create(name: "Holunderbeere", seasons: [.August, .September], in: context)
        let kartoffeln = Seasonal.create(name: "Kartoffeln", seasons: [.June, .July, .August, .September, .October], in: context)
        let kirsche = Seasonal.create(name: "Kirsche", seasons: [.June, .July, .August], in: context)
        let kohlrabi = Seasonal.create(name: "Kohlrabi", seasons: [.May, .June, .July, .August, .September, .October], in: context)
        let kopfsalat = Seasonal.create(name: "Kopfsalat", seasons: [.June, .July, .August, .September, .October], in: context)
        let lollorosso = Seasonal.create(name: "Lollo Rosso", seasons: [.April, .May, .June, .July, .August, .September, .October, .November], in: context)
        let mais = Seasonal.create(name: "Mais", seasons: [.October, .July, .August, .September], in: context)
        let mangold = Seasonal.create(name: "Mangold", seasons: [.May, .June, .July, .August, .September, .October], in: context)
        let mirabelle = Seasonal.create(name: "Mirabelle", seasons: [.July, .August, .September], in: context)
        let moehre = Seasonal.create(name: "Möhre", seasons: [.October, .July, .August, .September], in: context)
        let nektarine = Seasonal.create(name: "Nektarine", seasons: [.July, .August, .September], in: context)
        let pakchoi = Seasonal.create(name: "Pak Choi", seasons: [.May, .June, .July, .August, .September, .October], in: context)
        let paprika = Seasonal.create(name: "Paprika", seasons: [.June, .July, .August, .September, .October], in: context)
        let pastinake = Seasonal.create(name: "Pastinake", seasons: [.January, .February, .November, .December], in: context)
        let pfirsich = Seasonal.create(name: "Pfirsich", seasons: [.July, .August, .September], in: context)
        let pflaume = Seasonal.create(name: "Plaume", seasons: [.July, .August, .September], in: context)
        let poree = Seasonal.create(name: "Poree", seasons: [.August, .September, .November, .December], in: context)
        let quitte = Seasonal.create(name: "Quitte", seasons: [.November, .December], in: context)
        let radicchio = Seasonal.create(name: "Radicchio", seasons: [.June, .July, .August, .September, .October], in: context)
        let radieschen = Seasonal.create(name: "Radieschen", seasons: [.April, .May, .June, .July, .August, .September, .October], in: context)
        let rhabarber = Seasonal.create(name: "Rhabarber", seasons: [.March, .April, .May, .June, .July], in: context)
        let rosenkohl = Seasonal.create(name: "Rosenkohl", seasons: [.January, .October, .November, .December], in: context)
        let rotebete = Seasonal.create(name: "Rote Bete", seasons: [.September, .October, .November, .December], in: context)
        let rotkohl = Seasonal.create(name: "Rotkohl", seasons: [.May, .June, .July, .August, .September, .October, .November], in: context)
        let rucola = Seasonal.create(name: "Rucola", seasons: [.March, .April, .May, .June, .July, .August, .September, .October, .November], in: context)
        let gurke = Seasonal.create(name: "Gurke", seasons: [.May, .June, .July, .August], in: context)
        let sellerie = Seasonal.create(name: "Sellerie", seasons: [.June, .July, .August, .September, .October, .November, .December], in: context)
        let spargel = Seasonal.create(name: "Spargel", seasons: [.April, .May, .June], in: context)
        let spinat = Seasonal.create(name: "Spinat", seasons: [.April, .May, .June, .July, .August, .September, .October], in: context)
        let spitzkohl = Seasonal.create(name: "Spitzkohl", seasons: [.May, .June, .July, .August, .September, .October], in: context)
        let suesskartoffel = Seasonal.create(name: "Süßkartoffel", seasons: [.September, .October], in: context)
        let tomate = Seasonal.create(name: "Tomate", seasons: [.July, .August, .September], in: context)
        let weintraube = Seasonal.create(name: "Weintraube", seasons: [.September, .October], in: context)
        let weisskohl = Seasonal.create(name: "Weißkohl", seasons: [.August, .September, .October], in: context)
        let wirsing = Seasonal.create(name: "Wirsing", seasons: [.January, .February, .June, .July, .August, .September, .October, .November, .December], in: context)
        let zucchini = Seasonal.create(name: "Zucchini", seasons: [.June, .July, .August, .September], in: context)
        let zwiebel = Seasonal.create(name: "Zwiebel", seasons: [.July, .August, .September, .October, .November], in: context)
        
        apfel.createCharacteristic(1, name: "Wissenswertes", value: "Als Urahn des Apfels gilt unter Botanikern der sogenannte Holzapfel – auch Wilder Apfel genannt – aus Zentral- und Westasien. Aus seinen sehr kleinen und herben Früchten entstanden im Lauf vieler Jahrhunderte weltweit mehrere tausend verschiedene Sorten. Die ersten kultivierten Äpfel gab es im antiken Griechenland und im alten Rom; aber erst im 16. Jahrhundert wurden Äpfel in Europa allmählich zum Volksnahrungsmittel. Gut zu wissen: Mit dem Granatapfel ist er trotz Namensvetterschaft botanisch nicht verwandt.")
        apfel.createCharacteristic(2, name: "Herkunft", value: "Als Urahn des Apfels gilt unter Botanikern der sogenannte Holzapfel – auch Wilder Apfel genannt – aus Zentral- und Westasien. Aus seinen sehr kleinen und herben Früchten entstanden im Lauf vieler Jahrhunderte weltweit mehrere tausend verschiedene Sorten. Die ersten kultivierten Äpfel gab es im antiken Griechenland und im alten Rom; aber erst im 16. Jahrhundert wurden Äpfel in Europa allmählich zum Volksnahrungsmittel. Gut zu wissen: Mit dem Granatapfel ist er trotz Namensvetterschaft botanisch nicht verwandt.")
        apfel.createCharacteristic(3, name: "Saison", value: "Die Erntezeit für heimische Äpfel startet im Juli und geht bei einigen Sorten bis in den November hinein.")
        apfel.createCharacteristic(4, name: "Sorten", value: "Viele Äpfel, besonders aus Importen, schmecken hauptsächlich leicht süß und sonst wenig typisch; heimische und alte Sorten haben häufig einen kräftigen bis sehr intensiven Geschmack. Zu den alten Sorten gehören Boskop, Cox Orange, Goldparmäne oder der Danziger Kantapfel. Manche Apfelsorten wie z.B. Granny Smith oder Boskop schmecken leicht bis deutlich säuerlich und wieder andere (etwa Red Delicious oder Starking) haben ein parfümartiges Aroma. Alte Sorten sind wegen der sekundären Pflanzenstoffe, der Polyphenole, sogar ein Geheimtipp für Allergiker: Die Polyphenole binden die Allergene, deshalb werden sie oft besser vertragen. Sie sind aus den neuen Sorten herausgezüchtet, sodass diese süßer schmecken.")
        
        champignons.createCharacteristic(1, name: "Wissenswertes", value: "Champignons werden in speziell dafür angelegten Tunneln mit Klimakontrolle gezüchtet. Die Pilze reifen je nach gewünschter Größe innerhalb von 4-5 Wochen. Geerntet wird täglich und zwar per Hand, denn diese Methode garantiert, dass  die Champignons makellos und ohne Reste von Erde aus den Beeten kommen. Trotzdem liegen die Preise für Champignons erfreulich niedrig, denn ein geübter Pflücker schafft pro Stunde bis zu 30 Kilogramm. Die Pflücker sortieren auch gleich nach der Ernte nach Qualität, Gewicht und Größe.")
        champignons.createCharacteristic(2, name: "Herkunft", value: "Champignons stehen in der Hitliste der beliebten Speisepilze ganz oben: Der Pro-Kopf-Verbrauch liegt in Deutschland bei rund 2,9 Kilogramm – das ist mehr als in Frankreich, woher die feinen Pilze ursprünglich stammen. Dort kam ein Melonenzüchter in der Mitte des 17. Jahrhunderts durch einen Zufall auf die Idee, weiße Champignons auf dem Düngerabfall seiner Melonenzucht züchtete. Der erste Zuchtpilz Europas wurde auch darum als 'Pariser Pilz' bekannt, weil er schon wenig später vor dem Bau der Metro in den Katakomben der französischen Hauptstadt im großen Stil gezüchtet wurde. Dort herrschte das ideale Klima für den Anbau von Champignons, die es feucht lieben.")
        champignons.createCharacteristic(3, name: "Braune Champignons", value: "In Größe und Form unterscheiden sich braune Champignons nicht von ihren weißen Geschwistern – wohl aber, was Farbe und Geschmack angeht. Braune Champignons haben ein intensiveres, leicht nussiges Aroma. Außerdem schätzen viele an diesen Champignons, dass sie etwas weniger Wasser enthalten und darum beim Garen weniger schrumpfen und angenehm fest bleiben.")
        champignons.createCharacteristic(4, name: "Weiße Champignons", value: "Sie sind noch immer am beliebtesten und in drei Varianten zu haben: Miniatur-Champignons haben nur einen Durchmesser von 2 Centimetern und eine besonders feste Konsistenz. Geschlossene Champignons mittlerer Größe erreichen etwa 2,5 bis 3 Centimeter und geöffnete Champignons mit dunkelbraunen Lamellen bis zu 5 Centimeter.\nTipp: Damit die kleinen und mittleren Champignons ihre schöne schneeweiße Farbe behalten, beträufelt man sie am besten nach dem Putzen und Schneiden mit etwas Zitronensaft.")
        champignons.createCharacteristic(5, name: "Riesenchampignons", value: "Damit diese Sorte ihrem Namen alle Ehre macht, lässt man weiße Champignons länger wachsen, sodass ihr Hut einen Durchmesser von etwa 12 Centimeter erreicht. Die Maxi-Version in braun heißt Portobello, weil sie in England besonders begehrt ist. Beide Varianten eignen sich mit ihrer Größe perfekt zum Füllen und Überbacken. Ein leckeres Beispiel sind gefüllte Portobello-Pilze oder gefüllte Riesenchampignons. Man kann Riesenchampignons beziehungsweise Portobello-Pilze aber auch prima wie ein vegetarisches 'Schnitzel' braten.")
        
        chinakohl.createCharacteristic(1, name: "Wissenswertes", value: "Nomen est Omen: Der Chinakohl stammt tatsächlich ursprünglich aus China, wo man das knackige Gemüse schon seit dem 5. Jahrhundert kennt. Aber auch im übrigen Asien ist Chinakohl ein Gemüse mit VIP-Status: Die Koreaner stellen daraus zum Beispiel ihr berühmtes Kimchi (scharf gewürzten und eingelegten Kohl) her. In thailändischen Garküchen schnippelt man Chinakohl in die Nudelsuppe. Die Japaner schätzen das Gemüse ebenfalls und haben sogar eine ganz neue Sorte gezüchtet.")
        chinakohl.createCharacteristic(2, name: "Herkunft", value: "Die bei uns kultivierte und am meisten verkaufte Sorte stammt von einem chinesischen Urahnen mit dem Namen Zahn des weißen Drachen ab. Trotz des deutschen Namens ist der vermutlich aus einer Kreuzung von Speiserübe und Pak Choi (einer asiatischen Kohlart) entstandene Chinakohl botanisch mit unserem Kohl übrigens nur sehr entfernt verwandt.")
        chinakohl.createCharacteristic(3, name: "Saison", value: "Chinakohl gibt es das ganze Jahr über.")
        chinakohl.createCharacteristic(4, name: "Vorbereitung", value: "Die Blattrippen von Chinakohl sind so zart, dass man sie problemlos mitessen kann. Das Putzen und Vorbereiten geht darum ganz fix. Welke äußere Blätter entfernen, den Chinakohl kurz waschen und in einem Sieb abtropfen lassen. Anschließend je nach Rezept zerkleinern.")

        feldsalat.createCharacteristic(1, name: "Wissenswertes", value: "Klein, aber oho: Die Blättchen von Feldsalat mögen bescheidene Ausmaße haben, doch dafür können sie mit jeder Menge Power für unsere Gesundheit punkten. Wozu den oft nitratbelasteten Treibhaussalat oder teure Importe aus exotischen Gefilden auf den Teller bringen – auch hierzulande gibt es schließlich im Herbst und Winter frisches Grün. Die von den Österreichern liebevoll Vogerlsalat getauften Pflänzchen punkten mit einem besonders delikaten Geschmack.\nGanz billig ist das bei uns je nach Gegend auch Ackersalat oder Rapunzelsalat genannte Blattgemüse nicht und das kann es auch kaum sein, denn nach wie vor müssen die zarten Pflanzen mühsam per Hand geerntet werden. Auf den Markt kommt Feldsalat büschelweise und zwar mitsamt den feinen Wurzeln. Sie machen zwar beim Putzen etwas Arbeit, sorgen aber dafür, dass Feldsalat so schön knackig bleibt wie wir ihn kennen und lieben.\nWie sein Name schon verrät, kommt Feldsalat tatsächlich frisch vom Feld. Unter den Blattsalaten ist er schon wegen seiner Robustheit einzigartig, denn im Gegensatz zu all seinen Konkurrenten verträgt er problemlos Temperaturen bis zu minus 15 Grad. Dennoch baut man Feldsalat längst auch unter Glas beziehungsweise unter Folie an.")
        feldsalat.createCharacteristic(2, name: "Herkunft", value: "Auch wenn Feldsalat längst in beinahe ganz Nord- und Osteuropa bekannt und beliebt ist – seine eigentliche Heimat liegt in Eurasien. In diesem Gebiet, das von den Kanaren über Nordafrika bis zum Kaukasus reicht, wächst der Feldsalat bis heute wild am Wegesrand. Kultiviert wird Feldsalat erst seit dem vorigen Jahrhundert.\nDie Hauptanbaugebiete für Feldsalat vom Freiland liegen bei uns in Deutschland vor allem in Baden-Württemberg, gefolgt von Rheinland-Pfalz und Nordrhein-Westfalen.")
        feldsalat.createCharacteristic(3, name: "Saison", value: "Feldsalat vom Freiland bekommt man von Oktober bis etwa März oder April, je nach Witterung.")
        feldsalat.createCharacteristic(4, name: "Sorten", value: "Generell unterscheidet man bei Feldsalat zwei Sortengruppen: Die eine besteht aus Sorten mit relativ großen Blättern, die andere – von Kennern am meisten geschätzt – hat kleine Blättchen und häufig eine besonders intensiv dunkelgrüne Farbe.")
        
        kartoffeln.createCharacteristic(1, name: "Wissenswertes", value: "Kartoffeln sind unentbehrliche Grundnahrungsmittel und so wichtig wie das tägliche Brot. Die in den USA gern als Dickmacher verpönten Knollen sind tatsächlich echte Schlankmacher, sozusagen natürliche \"Light-Produkte\". Ohne Fett zubereitet liefern Kartoffeln wenig Kalorien und sättigen trotzdem angenehm und anhaltend. Das Eiweiß der Kartoffeln ist so hochwertig, dass es in Kombination mit Milch oder Eiern den Wert von Fleisch bei Weitem übersteigt.")
        kartoffeln.createCharacteristic(2, name: "Herkunft", value: "Bereits vor tausenden von Jahren bauten die Inkas aus Südamerika Kartoffeln an, bevor die Kartoffeln Mitte des 16. Jahrhunderts von spanischen Eroberern nach Europa gebracht wurden. König Friedrich II. machte die Kartoffel dann auch hierzulande bekannt, indem er nach einer großen Hungersnot im Jahr 1756 Bauern zum Anbau zwang. Die Kartoffel setzte sich nach und nach durch und wurde im Laufe des 19. Jahrhunderts zu einem wichtigen Grundnahrungsmittel, als die Städte immer bevölkerungsreicher wurden.")
        kartoffeln.createCharacteristic(3, name: "Saison", value: "Deutsche Frühkartoffeln gibt es ab Ende Mai oder Anfang Juni, mittelfrühe Sorten kommen Anfang August hinzu. Spätkartoffeln gehören hierzulande zu den am meisten angebauten Sorten, die auch hervorragend gelagert werden können.")
        kartoffeln.createCharacteristic(4, name: "Sorten", value: "Viel Farbe bringen exotische Neulinge auf unseren Teller. Da sind die fast schwarze Trüffelkartoffel, der blaue Schwede, Highland Red Burgundy oder Pink Fir Apple. Sie verlieren allerdings etwas Farbe beim Kochen. Wer das vermeiden möchte, kann zur Vitelotte, Violetta und der Roten Emma greifen. Ein bunter Kartoffelsalat bringt Ihre Gäste garantiert zum Staunen. ")
        
        kohlrabi.createCharacteristic(1, name: "Wissenswertes", value: "Wie der Name schon andeutet, gehört Kohlrabi zwar botanisch zur Familie der Kohlgewächse, erinnert geschmacklich aber nur entfernt an die deftigen Verwandten. Im Gegensatz zu anderen Kohlarten entsteht Kohlrabi übrigens nicht aus den Blättern oder Blüten der Pflanze, sondern durch eine oberirdische Verdickung des Pflanzenstiels. Entstanden ist Kohlrabi durch eine Kreuzung aus wildem Kohl und wilden weißen Rüben, dementsprechend ist seine ursprüngliche Farbe ein helles Grün. Inzwischen kennt man aber auch violetten Kohlrabi, der sich aber im Geschmack und in den Inhaltsstoffen nicht von der grünen Sorte unterscheidet.")
        kohlrabi.createCharacteristic(2, name: "Herkunft", value: "Die genaue Herkunft des Kohlrabis ist bis heute umstritten. Fest steht nur, dass seine Heimat im europäischen Raum liegt. Als sicher gilt jedoch, dass das Gemüse schon bei den alten Römern als \"caulo rapa\" bekannt und sehr beliebt war. In Deutschland wurde Kohlrabi erstmals 1558 erwähnt. Heute sind wir mit etwa 40.000 Tonnen jährlich die größten Erzeuger innerhalb Europas und haben gleichzeitig auch den größten Verbrauch.")
        kohlrabi.createCharacteristic(3, name: "Saison", value: "Kohlrabi bekommt man zwar das ganze Jahr über, am besten schmeckt er aber jung und frisch vom Feld – also in der Zeit von April/Mai bis in den Spätsommer hinein.")
        
        kopfsalat.createCharacteristic(1, name: "Wissenswertes", value: "Der gute alte Kopfsalat wird bei uns inzwischen häufig links liegen gelassen. Das mag zum Einen daran liegen, dass er in den vielen neueren Salatsorten aus den Mittelmeerländern und besonders durch den Eisbergsalat mächtige Konkurrenten bekommen hat. Zum Anderen hat ihn auch der Anbau unter Glas etwas in Verruf gebracht. Tatsächlich stimmt es, dass bei Kopfsalat aus dem Treibhaus sehr häufig hohe Nitratwerte gefunden werden. Experten raten darum, Kopfsalat möglichst während der Freilandsaison zu essen.\nDer Kopfsalat aus Freilandanbau hat ein Comeback absolut verdient, denn er punktet mit feinem Geschmack und durchaus wertvollen Inhaltsstoffen. Die Franzosen wissen seine Qualitäten besonders zu schätzen und verwenden ihn sogar als Gemüse. In Frankreich liebt man übrigens besonders den roten Kopfsalat, eine bei uns immer noch eher seltene Sorte. Roter Kopfsalat hat etwas zartere Blätter als der übliche grüne.\nAm beliebtesten sind bei Feinschmeckern aller Länder die gleichzeitig knackigen und zarten Herzen des Kopfsalats. Allerdings stecken die meisten gesunden Nährstoffe in den dunkleren und etwas kräftigeren Außenblättern.")
        kopfsalat.createCharacteristic(2, name: "Herkunft", value: "Der Urahn des Kopfsalats ist nach Ansicht von Botanikern der wilde Zaunlattich, der seine ursprüngliche Heimat in Südeuropa, Westasien und Nordafrika hat.")
        kopfsalat.createCharacteristic(3, name: "Saison", value: "Den ersten jungen Kopfsalat vom Feld bekommt man bei uns ab Mai und dann den ganzen Sommer über. Kopfsalat aus dem Treibhaus ist das ganze Jahr über zu haben.")
        
        lollorosso.createCharacteristic(1, name: "Wissenswertes", value: "Der attraktive Krauskopf gehört zur Gruppe der Schnitt- und Pflücksalate und ist daher bei genauerem Hinsehen gar kein Kopf, sondern bildet eine Rosette. Es gibt verschiedene Sorten, darunter solche mit fast durchweg roten Blättern. Andere haben grüne Blätter, die sich erst zum Rand hin dunkel- bis weinrot färben.")
        lollorosso.createCharacteristic(2, name: "Herkunft", value: "Der Name verrät es eigentlich schon: Der Lollo rosso stammt aus Italien. Man baut ihn inzwischen aber auch in Frankreich, Deutschland, der Schweiz und in den Niederlanden an.")
        lollorosso.createCharacteristic(3, name: "Saison", value: "Die Saison für Lollo rosso vom Freiland ist erfreulich lang: sie dauert von Mai bis Oktober. In den übrigen Monaten können Sie Lollo rosso aber auch aus Treibhausanbau bekommen.")
        
        moehre.createCharacteristic(1, name: "Wissenswertes", value: "Schon die Vielzahl der verschiedenen Namen für Möhren zeigt, dass es sich um ein ausgesprochen beliebtes und allgemein bekanntes Gemüse handelt: Je nach Region nennt man es auch Gelbe Rübe, Karotte, Wurzel, Mohrrübe, Gelbe Wurzel, Gelbrübe, Woddel, Rübe, Rübli oder Feldrübli. Verwunderlich ist diese Beliebtheit kaum, denn Möhren schmecken gut, sind sehr kalorienarm, kosten wenig und haben hohen gesundheitlichen Wert.\nZu schätzen wusste man die vielen Vorteile der Möhre offenbar schon weit zurückliegend: Die ältesten Möhrensamen fanden Forscher bisher in Schweizer Pfahlbauen aus der Zeit um 2000 v. Chr., und bereits im Altertum hatte das Gemüse einen guten Ruf sowohl als Gemüse- als auch als Arzneipflanze. Während Möhren in alten Zeiten wild wuchsen, hat man sie längst \"gezähmt\" und baut sie in Kulturen an. Ganz verleugnen kann die Möhre ihren Stammbaum aber nicht: Unsere heutigen Sorten sind im Lauf der Jahrtausende und Jahrhunderte durch die Kreuzung der verschiedenen Wildformen entstanden.\nDie Vielfalt ist riesig: Immer häufiger sieht man das Gemüse nicht nur in der typischen Farbe Orange, sondern auch in den traditionellen Farben wie Hellgelb, Gelb, Dunkelorange, Hellrot, Rot und sogar Dunkelviolett bis Schwarz. Schwarz sind auch Möhren, die im Moor wachsen - allerdings liegt das nicht an Zuchtmethoden, sondern an der tiefschwarzen Moorerde. Jedenfalls gelten diese Möhren als besonders aromatisch.\nMöhre und Karotte sind übrigens botanisch das Gleiche, trotzdem bezeichnet man in der Lebensmittelindustrie und im Großhandel nur die kurzen, eher stumpfen Exemplare als Karotte.")
        moehre.createCharacteristic(2, name: "Herkunft", value: "Botaniker vermuten die ursprüngliche Heimat in Südeuropa und Asien.")
        moehre.createCharacteristic(3, name: "Saison", value: "Möhren sind das ganze Jahr über aus einheimischem Anbau erhältlich; zwischen Oktober und Dezember ist das Angebot besonders groß. Im Frühjahr und Sommer sind die sogenannten Bundmöhren erhältlich. Ab dem Sommer bis in den Winter hinein gibt es dann die Waschmöhren, die nach der Ernte in Waschanlagen vorgewaschen werden und dann verpackt im Handel liegen. Waschmöhren enthalten mehr Ballaststoffe und weniger Zucker als die etwas süßeren Bundmöhren. ")

        pakchoi.createCharacteristic(1, name: "Wissenswertes", value: "Bis vor rund 20 Jahren kannten bei uns höchstens diejenigen Pak Choi, die vor Ort in den Garküchen Chinas, Thailands oder anderer asiatischer Länder davon probiert hatten. Auch heute noch kommt er hierzulande meistens in den Woks von Asia-Restaurants und -Imbissen zum Einsatz. In Europa ist der auch Paksoi genannte Kohl eben noch fast ein Newcomer. Äußerlich ähnelt er am ehesten dem Stielmangold, von der Konsistenz her ist Pak Choi mit dem etwas bekannteren Chinakohl vergleichbar.\nDie knackigen Köpfe mit den kräftigen weißen Blattrippen wiegen zwischen 200 und 600 Gramm. Pak Choi wächst zwar auch bei uns, wird aber hierzulande selten angebaut – fast immer kommt der exotische Kohl aus Thailand oder aus den Niederlanden, wo er teils auf dem Freiland, teils im Treibhaus wächst.")
        pakchoi.createCharacteristic(2, name: "Herkunft", value: "Wie sein deutscher Zweitname Chinesischer Senfkohl bereits vermuten lässt, stammt Pak Choi aus Asien. In China, Korea und Japan kennt man das botanisch eng mit dem Chinakohl verwandte Gemüse schon lange.")
        pakchoi.createCharacteristic(3, name: "Saison", value: "Da Pak Choi sowohl auf dem Feld als auch im Treibhaus gedeiht, kann man ihn das ganze Jahr über kaufen.")
        pakchoi.createCharacteristic(4, name: "Sorten", value: "In Asien kennt man verschiedene Varianten von Pak Choi, zum Beispiel auch Sorten mit hellgrünen statt weißen Blattrippen. Ziemlich beliebt sind auch der sogenannte Baby Pak Choi und der Shanghai Pak Choi – beide Sorten sind sehr viel kleiner und zarter als der herkömmliche Pak Choi, aber während Baby Pak Choi besonders mild schmeckt, hat Shanghai Pak Choi einen besonders würzigen Geschmack.")
        
        pastinake.createCharacteristic(1, name: "Wissenswertes", value: "Obwohl die Pastinake bei uns auch Germanenwurzel heißt, kennt man sie in Großbritannien, den USA und Frankreich viel besser als in Deutschland. Hierzulande ist die Wurzel lange in Vergessenheit geraten gewesen: Während Pastinaken in früheren Zeiten häufig auf den Tisch kamen, gerieten sie sozusagen aus der Mode, nachdem unsere Vorfahren auf den Geschmack von Kartoffeln gekommen waren. Erst seit ein paar Jahren liegen Pastinaken wieder im kulinarischen Trend – nicht zuletzt bei Sterneköchen übrigens, denn aus dem würzigen Wurzelgemüse lassen sich sowohl deftige Eintöpfe als auch feine Suppen und Pürees zubereiten.\nDie äußerliche Ähnlichkeit mit Petersilienwurzeln ist übrigens keineswegs zufällig: Pastinaken gelten bei Botanikern als Kreuzung aus Karotte und Petersilie.")
        pastinake.createCharacteristic(2, name: "Herkunft", value: "In ihrer Wildform ist die Pastinake in ganz Europa bis hin nach Eurasien seit vielen Jahrhunderten bekannt. Heute baut man sie in Kulturen vor allem in Skandinavien, den Niederlanden, England, Frankreich und in den USA an.")
        pastinake.createCharacteristic(3, name: "Saison", value: "Pastinaken gehören zu den typischen Herbst- und Wintergemüsen; man bekommt sie ab Oktober bis Mitte März.")

        poree.createCharacteristic(1, name: "Wissenswertes", value: "An dem ebenso schlichten und anspruchslosen wie begehrten Porree (auch Lauch genannt) muss mehr dran sein, als man ihm ansieht. Immerhin hat er eine lange und durchaus ruhmreiche Geschichte: Schon um 2.100 vor Christus ließ der sumerische Herrscher Umammu dieses Gemüse aus der Familie der Liliengewächse in den Gärten der Stadt Ur anbauen. Im alten Ägypten sollen sich die Arbeiter, welche die Pyramiden erbauten, mit Porree ernährt haben.\nDen berühmt-berüchtigten römischen Kaiser Nero nannten unerschrockene Untertanen sogar Porrophagus (zu deutsch „Porreefresser“), weil er die würzigen Stangen so überaus schätzte. Die Waliser haben Porree sogar in ihrem Wappen verewigt, nachdem der Britenkönig Cadwallader es um 640 als Erkennungszeichen für seine Truppen verwendet hatte.\nMit so viel Glanz und Ruhm verglichen, fristet Porree natürlich heute ein sehr bescheidenes Dasein. Aber überaus beliebt ist er immer noch, wie schon sein Einsatz als unverzichtbarer Teil des Suppengrüns zeigt. Und auch die Tatsache, dass Porree praktisch rund ums Jahr Dauerpräsenz auf dem Markt besitzt, beweist seine große Bedeutung als vielseitiges Gemüse.")
        poree.createCharacteristic(2, name: "Herkunft", value: "Porree gehört zu den wenigen Gemüsesorten, bei denen die Botaniker die ursprüngliche Heimat nicht kennen, sondern nur vermuten – und zwar im Mittelmeerraum.")
        poree.createCharacteristic(3, name: "Saison", value: "Porree aus Freilandanbau hat von Juni bis März Saison. In der kurzen Zwischenzeit kommt er aus Frühkulturen, die unter Glas oder Folie liegen.")
        
        radieschen.createCharacteristic(1, name: "Wissenswertes", value: "Sie meinen, Radieschen seien ein typisch deutsches Gemüse? Das stimmt und stimmt auch wieder nicht: Zwar sind die kleinen Knollen vor allem in Süddeutschland ein beliebtes Schmankerl und wachsen auch in ganz Deutschland. Doch die Heimat der botanisch zu den Kreuzblütlern gehörenden Radieschen liegt eigentlich im Fernen Osten. Von dort, wo sie bereits im Altertum als Zierpflanzen japanische und chinesische Gärten verschönerten, kamen sie erst vor rund 500 Jahren nach Mitteleuropa. Heute werden sie weltweit angebaut, und das keineswegs nur in ihrer allgemein bekannten Farbe.\nAußer den runden knallroten Radieschen gibt es auch solche mit weißen Spitzen; sogar durch und durch ganz weiße Radieschen kommen vor. Form und Größe können ebenfalls variieren: Zu haben sind Radieschen von haselnussgroß und kugelrund bis pflaumengroß oder langoval. Nur das Innere von Radieschen ist immer gleich, nämlich schneeweiß.")
        radieschen.createCharacteristic(2, name: "Herkunft", value: "Über die ursprüngliche Heimat von Radieschen sind sich Botaniker nicht ganz einig – fest steht, dass sie in Wildform bereits im Altertum in China und Japan wuchsen. Auch die alten Ägypter und Griechen der Antike kannten die Urform des Radieschens. In Europa wachsen Radieschen erst seit dem 16. Jahrhundert; damals kamen sie zuerst in Frankreich in Mode.")
        radieschen.createCharacteristic(3, name: "Saison", value: "Radieschen können Sie das ganze Jahr über frisch kaufen, da sie auch im Unterglasanbau gut gedeihen. Viele mögen aber Radieschen vom Freiland lieber – dort startet die Erntezeit im Frühjahr und dauert bis in den Herbst.")
        radieschen.createCharacteristic(4, name: "Sorten", value: "Ob rund und rot, zylindrisch und weiß oder oval und zweifarbig – gerade auf dem Wochenmarkt finden sich viele verschiedene Radieschensorten. Das Fleisch ist allerdings stets weiß. ")
        
        rhabarber.createCharacteristic(1, name: "Wissenswertes", value: "Er leitet sich vom lateinischen \"Rheum rhabarbarum\" ab – was übersetzt nichts anderes heißt als \"Wurzel der Barbaren\". So nannten die alten Römer die Pflanze, die von den bei ihnen als Barbaren angesehenen Tataren an den Ufern der Wolga (damals \"Rha\" genannt) angebaut wurde. Deren heutige Nachfahren denken über Rhabarber längst ähnlich wie die Römer: \"In Russland gilt Rhabarber eigentlich als nicht essbar. Weil er nicht schmeckt. Das ist doch absurd!\" macht sich zum Beispiel Wladimir Kaminer lustig über die Begeisterung für das saure Frühlingsgemüse, die hierzulande jedes Frühjahr herrscht.\nAuch wenn wir Rhabarber fast ausschließlich süß zubereitet kennen und essen, gehört er botanisch nicht zum Obst, sondern zum Gemüse. Sein Anbau erfordert relativ viel Aufwand. Schon im Januar spannen die Bauern Folie über die Felder, sodass eine Art natürliches Treibhaus entsteht, in dem der Rhabarber besonders schnell wächst. Etwa Anfang März entfernt man dann die Folie und lässt den Rhabarber ohne Frostschutz wachsen. Lässt man ihn länger auf dem Feld, werden die Stangen dicker, faseriger und saurer. Meist erntet man Rhabarber aber schon, wenn er noch jung und zart ist.")
        rhabarber.createCharacteristic(2, name: "Herkunft", value: "Die ursprüngliche Heimat von Rhabarber liegt in Tibet und in der Mongolei.")
        rhabarber.createCharacteristic(3, name: "Saison", value: "Den ersten jungen Rhabarber bekommt man schon Ende März oder – je nach Wetter – Anfang April. Von da an dauert seine Saison rund drei Monate. Spätestens Ende Juni ist Schluss. Dann brauchen die Pflanzen eine Ruhephase, um sich für die Ernte im nächsten Jahr zu erholen.")
        
        rotebete.createCharacteristic(1, name: "Wissenswertes", value: "Eine besonders große Rolle spielt Rote Bete in der nord- und osteuropäischen und in etwas geringerem Ausmaß teilweise auch in der norddeutschen Küche. Die berühmte polnische Suppe Borschtsch hat das auch Rote Rübe genannte Gemüse als Basis; das Hamburger Gericht Labskaus kommt nicht ohne Rote Bete aus, und dem klassischen roten Heringssalat gibt sie ebenfalls Farbe und Geschmack.\nApropos Farbe: Wegen seiner intensiven Färbekraft wird der in Roter Bete enthaltene natürliche Stoff Betanin auch seit langem als \"E 162\" bei der Lebensmittelherstellung eingesetzt und macht unter anderem Eis, Süßspeisen, Konfitüren und Nektare attraktiver.\nBesonders beliebt ist sauer eingelegte Rote Bete aus dem Glas. Große Rüben werden dafür in Scheiben oder Streifen geschnitten; kleine Exemplare bekommt man auch im Ganzen eingemacht. Viel Zeit lässt sich mit vakuumverpackter Rote Bete sparen, denn sie ist bereits vorgegart. Man bekommt sie in der Gemüseabteilung von praktisch jedem Super- und Discountermarkt.")
        rotebete.createCharacteristic(2, name: "Herkunft", value: "Wie so viele Gemüsesorten kam auch die Rote Bete mit den Römern nach Europa. Heute wächst sie problemlos auch in kälteren Gefilden wie zum Beispiel in Russland, Polen, Skandinavien sowie in vielen anderen europäischen Ländern – und natürlich auch bei uns.")
        rotebete.createCharacteristic(3, name: "Saison", value: "Frische Rote Bete findet man im Spätherbst und Winter bis weit ins Frühjahr hinein in jedem Supermarkt, beim Gemüsehändler oder auf dem Wochenmarkt.")
        
        sellerie.createCharacteristic(1, name: "Wissenswertes", value: "Was seine Pluspunkte für die Figur angeht, hat Staudensellerie seinem runden großen Bruder etwas voraus: Er gehört zu den kalorienärmsten Gemüsesorten überhaupt und enthält zudem kein Fett. Aber auch der dicke Knollensellerie kann sich als Schlankmacher durchaus sehen lassen, denn seine Kalorien- und Fettwerte liegen kaum höher.\nAber ob Staude oder Knolle: Seinen typischen Geschmack verdankt Sellerie den reichlich darin enthaltenen ätherischen Ölen, die ihn bekömmlich machen und den Stoffwechsel anregen sowie sanft entwässernd wirken. Generell hat Sellerie nennenswerte Mengen an Vitamin A, B, C und Vitamin E zu bieten. Auch der Gehalt an Ballaststoffen macht speziell Knollensellerie zu einem gesunden Genuss.\nForscher konnten nachweisen, dass Sellerie dazu beiträgt, den Blutfett- und Blutzuckerspiegel in der Balance zu halten. Außerdem wirken die Inhaltsstoffe von Sellerie antioxidativ. Sie schützen also die Körperzellen vor schädigenden freien Radikalen.")
        sellerie.createCharacteristic(2, name: "Lagerung", value: "Knollensellerie bleibt im Kühlschrank oder im Keller mehrere Wochen oder sogar Monate frisch. Staudensellerie ist sensibler und bleibt im Kühlschrank maximal zwei Wochen knackig.")
        
        spargel.createCharacteristic(1, name: "Wissenswertes", value: "Schon der mittelalterliche Maler Hieronymus Bosch soll gesagt haben, dass Spargel eine \"liebliche Speis für\" sei und der Dichter Carl Zuckmayer meinte: 'Wenn Du Kartoffeln oder Spargel isst, schmeckst Du den Sand der Felder und den Wurzelsegen, des Himmels Hitze und den kühlen Regen, kühles Wasser und den warmen Mist'. So oder ähnlich sehen es die meisten von uns und der Start in die Spargel-Saison ist für nicht wenige Genießer ein Freudenfest, das durch die Tatsache, dass zeitgleich die jungen Kartoffeln aus der Erde kommen, noch bedeutsamer wird. Beides zusammen gilt nicht erst seit gestern als Gipfel der kulinarischen Frühjahrs-Lust. Was wir so gerne essen, ist der junge Spross der eigentlichen Pflanze.\n Alle Jahre wieder findet traditionell Europas führender Spargel-Erzeugermarkt in Bruchsal statt. Der Ort liegt als Ziel an der sogenannten \"Spargelstraße\", die in Baden-Württemberg über Orte wie Ketsch, Hockenheim und Hambrücken führt. Ebenfalls in dieser Region liegt Schwetzingen, wo der zu Recht berühmte Schwetzinger Spargel zuhause ist. Schwetzingen steht unangefochten an der Spitze der für ihren Spargel berühmten Städte und gilt als eine Art kulinarisches Mekka für Spargelfans. Doch auch Spargel aus Niedersachsen beziehungsweise aus der Lüneburger Heide ist bei Kennern als ganz besonders lecker bekannt. Wichtige deutsche Anbaugebiete für das königliche Gemüse liegen bei uns außerdem in Hessen, Rheinland-Pfalz, Bayern und Nordrhein-Westfalen.\nObwohl viele Spargelfans nichts auf Stangen aus Deutschland kommen lassen, gibt es immer häufiger auch weißen und grünen Spargel aus anderen EU-Ländern wie Belgien, Frankreich, Spanien, den Niederlanden, Griechenland und Ungarn bei uns zu kaufen. Puristen bemängeln allerdings, dass diese Stangen selten so schneeweiß sind wie diejenigen, die in Deutschland gestochen werden. Ausländische Spargelimporte fallen oft dadurch auf, dass ihre Köpfe mehr oder weniger violett schimmern und die Stangen in der Regel einen weit geringeren Durchmesser haben als einheimische.")
        spargel.createCharacteristic(2, name: "Herkunft", value: "Wo genau die ursprüngliche Heimat von Spargel liegt, ist bis heute nicht wirklich geklärt. Man vermutet sie aber in Osteuropa, Vorder- und Mittelasien. Fest steht, dass Spargel heute in ganz Europa, in Nordafrika und auch im Norden der Vereinigten Staaten heimisch ist.")
        spargel.createCharacteristic(3, name: "Saison", value: "Die traditionelle Saison für Spargel beginnt hierzulande je nach Wetterlage Anfang bis Mitte Mai und endet nach dem Motto \"Kirschen rot, Spargel tot\" Ende Juni. Da aber inzwischen auch aus anderen Ländern Spargelimporte kommen, hat sich die Saison verlängert und beginnt schon Ende März.")

        spinat.createCharacteristic(1, name: "Wissenswertes", value: "Wer gerne Spinat isst, kann sich kaum vorstellen, dass ganze Generationen wegen dieses köstlichen Gemüses ungute Erinnerungen an die Mahlzeiten ihrer Kindheit hatten. Das liegt daran, dass wir heute ganz andere Sorten auf den Tisch bekommen. Früher enthielt Spinat mehr Bitterstoffe und Oxalsäure als heute, schmeckte entsprechend herb und hinterließ ein unangenehmes pelziges Gefühl im Mund. Das ist dank moderner Zuchtmethoden aber endgültig Geschichte. Was sich jedoch noch nicht geändert hat: Spinat speichert sehr viel Nitrat, das sich während der Lagerung sich Nitrit umwandelt, das insbesondere in großen Mengen ungesund ist. Daher am besten auf frischen Biospinat zurückgreifen möglichst schnell verzehren. Auch die früher übliche, nicht unbedingt appetitliche Zubereitung von Spinat als gehacktem und zerkochtem Brei, ist kaum noch üblich. Stattdessen kommt inzwischen immer häufiger Spinat in seiner leckersten Form – also als Blattspinat – auf den Tisch.")
        spinat.createCharacteristic(2, name: "Herkunft", value: "Botaniker vermuten die ursprüngliche Heimat von Spinat in Südwestasien, wo bis heute eine wild wachsende Urform vorkommt.")
        spinat.createCharacteristic(3, name: "Saison", value: "Vom Freiland kommt Spinat bei uns ab April bis Ende Oktober auf den Teller. In der übrigen Zeit gibt es Spinat aus Treibhauskulturen und als Importware zu kaufen.")
        spinat.createCharacteristic(4, name: "Sorten", value: "Grundsätzlich existieren zwar rund 50 verschiedene, in der Praxis unterteilt man aber nur in Frühjahrs-, Sommer- und Winterspinat. Junger Frühjahrs- und Sommerspinat hat kleinere, zarte und hellgrüne Blätter. Spinat aus später Ernte dagegen ist dunkelgrün, hat große und feste, fleischige Blätter.\nBesonders beliebt ist momentan der sogenannte Baby-Spinat mit seinen kleinen, zarten Blättchen und einem milderen Geschmack.")
        
        weisskohl.createCharacteristic(1, name: "Wissenswertes", value: "Bei uns gilt Weißkohl als die wichtigste, weil am meisten verkaufte aller sogenannten Kopfkohlarten. Rund 90 Prozent des in Deutschland verputzten Weißkohls kommt aus heimischem Anbau, den kleinen Rest importieren wir aus anderen Anbauländern und -gebieten wie Polen, Russland, Skandinavien, Großbritannien und Asien. Das größte geschlossene Anbaugebiet Europas liegt aber immer noch in Dithmarschen, wo man gemeinsam mit der Landwirtschaftskammer Kiel sogar eigene Qualitätsvorschriften für Weißkohl aufgestellt hat. Geerntet werden Weißkohlköpfe übrigens bis heute meistens noch per Hand. Nur die Verarbeitung in der Lebensmittelindustrie, zum Beispiel zu Sauerkraut, erledigen überwiegend Maschinen.")
        weisskohl.createCharacteristic(2, name: "Saison", value: "Weißkohl gilt zwar als eins der typischsten Wintergemüse und wird auch bevorzugt in der kalten Jahreszeit zubereitet. Tatsächlich wächst das Gemüse aber schon ab April auf unseren Feldern und ist dann je nach Sorte ganzjährig zu haben.")
        
        wirsing.createCharacteristic(1, name: "Wissenswertes", value: "Vor noch nicht allzu langer Zeit rümpften Feinschmecker über Wirsingkohl nur die Nase. Er galt wie Kohl ganz generell als typisches Arme-Leute-Essen. Inzwischen hat aber sogar die ehemals Neue Deutsche Küche den Krauskopf für sich entdeckt und das aus gutem Grund. Denn in der Tat ist Wirsingkohl im Vergleich zu Weiß- oder Rotkohl sozusagen was Besseres, jedenfalls dann, wenn man es eher fein als robust mag: Seine Blätter sind zarter und haben ein delikateres Aroma. Das gilt für Wirsingkohl allgemein, besonders aber für den hellgrünen und besonders zarten jungen Frühwirsing und Sommerwirsing. Späte Sorten beziehungsweise sogenannter Herbst- und Dauerwirsing ist in Konsistenz, Farbe und Aroma deutlich kräftiger.")
        wirsing.createCharacteristic(2, name: "Herkunft", value: "Die ursprüngliche Heimat der leckeren Krausköpfe liegt in den Ländern rund ums Mittelmeer. Inzwischen baut man Wirsingkohl aber längst auch bei uns in Deutschland sowie in Großbritannien, den Niederlanden, Frankreich, Polen und Russland an.")
        wirsing.createCharacteristic(3, name: "Saison", value: "Der erste Wirsingkohl des Jahres heißt kurioserweise Adventswirsing und wird schon im April geerntet. Frühwirsing und Sommerwirsing kommen ab Juni auf den Markt. Die Ernte von Herbstwirsing startet im August und dauert je nach Wetter und Region bis in den Februar. Von März bis Mai ist das Angebot an Wirsingkohl etwas eingeschränkter, aber auch dann gibt es dank ausgeklügelter Lagerung noch frische Köpfe.")
        wirsing.createCharacteristic(4, name: "Sorten", value: "Den Krauskopf gibt es in unterschiedlichen Sorten: Robuster Winterwirsing ist würzig-intensiver im Geschmack und hat stärker gekräuselte, dunklere Blätter als der zarte Sommerwirsing.")
        
        zwiebel.createCharacteristic(1, name: "Wissenswertes", value: "Wer denkt beim süßen Duft und dem Anblick von blühenden Lilien, Tulpen oder Hyazinthen schon an Zwiebeln? Trotzdem ist Tatsache: Blumen wie Gemüse zählen zur mit 220 Gattungen und 3500 verschiedenen Arten weitverzweigten Familie der Liliengewächse. Besonders zahlreich und weitverzweigt ist die Zwiebel-Familie, die Mitglieder in den verschiedensten Farben, Größen und Schärfegraden vorweisen kann.\nBei allen äußerlichen und geschmacklichen Unterschieden gibt es aber ein besonderes Kennzeichen, das sämtliche Mitglieder der delikaten Dynastie gemeinsam haben: Sie duften mal mehr, mal weniger intensiv würzig bis scharf. Das liegt an den darin üppig enthaltenen schwefelhaltigen Senfölen, die allen Zwiebeln ihren charakteristischen Geschmack sowie ihre Schärfe geben und sie besonders gesund machen. Das wusste man bereits im Ägypten des Altertums, wo Zwiebeln beim Bau der Pyramiden zur Stärkung der Sklaven sowie als Opfergabe dienten.\nDie heute auch bei uns längst eingebürgerten verschiedenen Sorten von Zwiebeln kennt man übrigens erst seit dem 15. Jahrhundert, als die Holländer mit speziellen Züchtungen begannen.")
        zwiebel.createCharacteristic(2, name: "Herkunft", value: "In ihrer ursprünglichen Heimat Zentralasien, Pakistan, Indien und dem Mittelmeerraum sind Zwiebeln seit mindestens 5.000 Jahren heimisch.")
        zwiebel.createCharacteristic(3, name: "Saison", value: "Frisch geerntete Zwiebeln erhalten Sie von Juli bis Oktober. Das restliche Jahr erhalten Sie die kleinen Knollen überwiegend als Lagerware.")
        zwiebel.createCharacteristic(4, name: "Speisezwiebel", value: "Sie ist robust und intensiv, auch als Küchen- oder Haushaltszwiebel bekannt und unentbehrlich für die tägliche Küche. Die braunschalige Urahnin aller heute bekannten Zwiebelsorten würzt Suppen, Eintöpfe, Schmorgerichte, Bratkartoffeln und vieles mehr. Erhältlich ist sie rund ums Jahr, allerdings schmecken junge Zwiebeln aus der ersten einheimischen Ernte im Frühjahr besonders gut. Dann eignen sie sich wunderbar zum rohen Verzehr, zum Beispiel im Salat.")
        zwiebel.createCharacteristic(5, name: "Rote Zwiebel", value: "Ihre dünne, dunkelrote bis violette Schale und das ebenfalls rötliche, milde Fleisch machen sie als dekorative und leckere Salatzwiebel besonders beliebt. Selbstverständlich können Sie mit roten Zwiebeln auch kochen, braten und backen. Solo oder mit anderen Zwiebeln kombiniert sorgen sie kulinarisch und optisch für das gewisse Etwas, zum Beispiel bei Zwiebelkuchen, Zwiebelsuppe oder Rührei.")
        zwiebel.createCharacteristic(6, name: "Weiße Zwiebel", value: "Italiener und Spanier lieben sie wegen ihres süßlichen und milden Geschmacks. Weiße Zwiebeln sind die ideale Sommerzwiebel, denn selbst Magenempfindliche können sie meist problemlos roh genießen. Einfach perfekt für mediterrane Salate. Sanft und kurz gedünstet, geben weiße Zwiebeln aber auch feineren Gerichten dezente Würze.")
        zwiebel.createCharacteristic(7, name: "Silberzwiebel", value: "Wer sie nur eingelegt aus dem Glas kennt, verpasst etwas! Die 15 bis 35 Millimeter kleinen weißen Zwiebelchen schmecken frisch nämlich ganz besonders köstlich. Ihr mild-würziger Geschmack machen Silber- oder Perlzwiebeln zur delikaten Beilage für Fleisch, Fisch oder Geflügel. Einfach schälen und mit Olivenöl im Ganzen bei kleiner Hitze 10 bis 20 Minuten schmoren.")
        zwiebel.createCharacteristic(8, name: "Gemüsezwiebel", value: "Das Schwergewicht der Zwiebelfamilie kommt vor allem aus Spanien zu uns. Form und Schale erinnern an die Küchenzwiebel, aber die Gemüsezwiebel wird bis zu 20 Zentimeter dick und schmeckt im Vergleich zur kleinen Schwester ganz besonders mild. Ihr weißes, sehr saftiges Fleisch bringt eine leichte Süße und eignet sich prima für Salate, zum Schmoren, Grillen sowie vor allem zum Füllen und anschließenden Überbacken.")
        zwiebel.createCharacteristic(9, name: "Schalotte", value: "Die mildeste und edelste aller Zwiebeln verdankt ihren Namen der palästinensischen Stadt Askalon, ist aber speziell in Frankreich nicht aus der feinen Küche wegzudenken. Runde Schalotten wie die 'Bretonne Ronde' sehen fast aus wie Küchenzwiebeln, haben aber das für die Edelzwiebel typische Aroma. Die meisten Schalotten haben eine längliche, birnenartige Form. Die Schale schimmert rosa bis rot oder kupferfarben.")

        
        let backen = RecipeCategory.create(name: "Backen", in: context)
        let glutenfrei = RecipeCategory.create(name: "Glutenfrei", in: context)
        let lowcarb = RecipeCategory.create(name: "Low Carb", in: context)
        let vegan = RecipeCategory.create(name: "Vegan", in: context)
        let vegetarisch = RecipeCategory.create(name: "Vegetarisch", in: context)
        
        let r1 = Recipe.create(name: "Apfel-Sellerie-Suppe", intro: "Gleich drei starke Zutaten verbinden sich zu einem sehr effektiven Trio: Apfel, Knollensellerie und Fenchel. Es senkt zum Beispiel den Cholesterinspiegel, lindert Erkältungen und schützt die Zellen vor freien Radikalen und wirkt deshalb positiv auf den gesamten Körper.", in: context)
        r1.createNutrition(calories: 278, protein: 7, fat: 19, carbs: 17)
        r1.createIngredient(name: "Apfel", quantity: 175, unit: "g")
        r1.createIngredient(name: "Fenchel", quantity: 1, unit: "Knolle")
        r1.createIngredient(name: "Gemüsebrühe", quantity: 600, unit: "ml")
        r1.createIngredient(name: "Rapsöl", quantity: 2, unit: "EL")
        r1.createIngredient(name: "Sellerie", quantity: 135, unit: "g")
        r1.createIngredient(name: "Sojacreme", quantity: 100, unit: "ml")
        r1.createIngredient(name: "Zwiebel", quantity: 1)
        r1.seasonals = [apfel, fenchel, sellerie, zwiebel]
        r1.categories = [vegan, vegetarisch, glutenfrei]
        r1.diets = [.Vegan, .GlutenFree, .Vegetarian]
        r1.createPreparation(text: "Zwiebel und Sellerie schälen und grob würfeln. Apfel schälen, vierteln, das Kerngehäuse entfernen, Apfel ebenfalls in grobe Würfel schneiden.", order: 1)
        r1.createPreparation(text: "Die Hälfte des Öls einem großen Topf erhitzen und die Zwiebelwürfel darin 2-3 Minuten bei mittlerer Hitze glasig dünsten. Sellerie- und Apfelstücke zugeben und 1 Minute dünsten. Brühe dazugießen, alles aufkochen und bei kleiner Hitze zugedeckt etwa 45 Minuten garen.", order: 2)
        r1.createPreparation(text: "Inzwischen Fenchel putzen, waschen und abtropfen lassen. Fenchel fein würfeln. Eine Pfanne erhitzen, restliches Öl hineingeben und Fenchelwürfel darin bei mittlerer Hitze unter ständigem Rühren rösten, bis alles gut gebräunt und weich ist. Mit Salz und Pfeffer würzen und warm halten.", order: 3)
        r1.createPreparation(text: "Suppenzutaten in der Brühe mit einem Stabmixer fein pürieren. Apfel-Sellerie-Suppe evtl. durch ein Sieb streichen (passieren) und zurück in den Topf gießen.", order: 4)
        r1.createPreparation(text: "Sojacreme dazugeben und alles nochmals ca. 1 Minute erhitzen. Apfel-Sellerie-Suppe mit Salz und Pfeffer abschmecken, in vorgewärmte Suppenteller verteilen und mit dem gerösteten Fenchel garniert servieren.", order: 5)
        
        let r2 = Recipe.create(name: "Frühlings-Risotto mit grünem Spargel", intro: "Der knackige grüne Spargel bringt viel Kalium ins Frühlings-Risotto und hilft so, den Flüssigkeitshaushalt des Körpers im Gleichgewicht zu halten. Auch das B-Vitamin Folsäure steckt im Spargel – das ist für die Zellerneuerung und die Blutbildung von großer Bedeutung. Auch die Verdauung kommt nicht zu kurz: Der Frühlingsbote Radieschen punktet mit Senfölen, welche die Produktion von Verdauungssäften anregen und für eine gute Darmtätigkeit sorgen.", in: context)
        r2.createNutrition(calories: 575, protein: 21, fat: 20, carbs: 76)
        r2.createIngredient(name: "Dill", quantity: 0.5, unit: "Bund")
        r2.createIngredient(name: "Gemüsebrühe", quantity: 650, unit: "ml")
        r2.createIngredient(name: "Grüner Spargel", quantity: 400, unit: "g")
        r2.createIngredient(name: "Kapern", quantity: 2, unit: "TL")
        r2.createIngredient(name: "Olivenöl", quantity: 2, unit: "EL")
        r2.createIngredient(name: "Parmesan", quantity: 60, unit: "g")
        r2.createIngredient(name: "Radieschen", quantity: 0.5, unit: "Bund")
        r2.createIngredient(name: "Risottoreis", quantity: 180, unit: "g")
        r2.createIngredient(name: "Zitronensaft", quantity: 1, unit: "Spritzer")
        r2.createIngredient(name: "Zwiebel", quantity: 0.5)
        r2.seasonals = [spargel, radieschen, zwiebel]
        r2.categories = [vegetarisch]
        r2.diets = [.Vegetarian]
        r2.createPreparation(text: "Halbe Zwiebel schälen und in Streifen schneiden. 1 EL Olivenöl in einem Topf erhitzen, Zwiebel und Risotto-Reis darin für 1 Minute bei mittlerer Hitze andünsten. Kapern zugeben und mit etwas Gemüsebrühe ablöschen. Unter gelegentlichem Rühren für ca. 20 Minuten nach und nach die Gemüsebrühe zugeben, bis der Reis die Flüssigkeit komplett aufgenommen hat.", order: 1)
        r2.createPreparation(text: "Inzwischen Spargel und Radieschen putzen und waschen. Die holzigen Enden des Spargels abschneiden und die Radieschen vierteln. Restliches Öl in einer Pfanne erhitzen und das Gemüse darin bei mittlerer Hitze für 3 Minuten unter Wenden anbraten und salzen. Dill waschen, trocken schütteln und grob hacken.", order: 2)
        r2.createPreparation(text: "Parmesan reiben und die Hälfte unter das Risotto rühren. Mit Pfeffer und Zitronensaft würzen und mit geschlossenem Deckel beiseitestellen.", order: 3)
        r2.createPreparation(text: "Risotto auf Tellern anrichten, Gemüse darübergeben und mit restlichem Parmesan und Dill bestreut servieren.", order: 4)
        
        let r3 = Recipe.create(name: "Griechisches Gemüse mit Feta", intro: "Hier kommen reichlich Vitamine und Mineralstoffe auf den Tisch: Insbesondere Kalium, Calcium und Phosphor stecken in den Fruchtgemüsen Zucchini und Aubergine. Die kräftig riechenden schwefelhaltigen Bestandteile der Knoblauchzehen, sogenannte Phytonzide, wirken als natürliche Antibiotika. Sie können krank machende Mikroorganismen abtöten, ohne dabei den Menschen mit Nebenwirkungen zu belasten.", in: context)
        r3.createNutrition(calories: 356, protein: 12, fat: 19, carbs: 32)
        r3.createIngredient(name: "Aubergine", quantity: 1)
        r3.createIngredient(name: "Feta", quantity: 100, unit: "g")
        r3.createIngredient(name: "Kartoffeln", quantity: 450, unit: "g")
        r3.createIngredient(name: "Kirschtomaten", quantity: 300, unit: "g")
        r3.createIngredient(name: "Knoblauch", quantity: 1, unit: "Knolle")
        r3.createIngredient(name: "Olivenöl", quantity: 5, unit: "EL")
        r3.createIngredient(name: "Paprika", quantity: 1)
        r3.createIngredient(name: "Thymian", quantity: 2, unit: "Zweige")
        r3.createIngredient(name: "Zucchini", quantity: 2)
        r3.createIngredient(name: "Zwiebel", quantity: 2)
        r3.seasonals = [aubergine, kartoffeln, tomate, paprika, zucchini, zwiebel]
        r3.categories = [vegetarisch, glutenfrei]
        r3.diets = [.Vegetarian, .GlutenFree]
        r3.createPreparation(text: "Zucchini und Aubergine putzen, waschen und quer in Scheiben schneiden. Zwiebeln schälen und in Achtel schneiden. Knoblauch von den äußeren Hüllblättern befreien und quer halbieren. Paprikaschote halbieren, entkernen, waschen und längs in Streifen schneiden. Kirschtomaten vorsichtig waschen und abtropfen lassen. Kartoffeln gründlich waschen und halbieren. Thymian waschen, trocken schütteln und Blättchen abzupfen.", order: 1)
        r3.createPreparation(text: "Auberginenscheiben in einer großen Auflaufform oder in einem tiefen Backblech verteilen. Paprikastreifen, Zucchinischeiben, Zwiebeln, Knoblauch, Tomaten und Kartoffeln darauf verteilen, alles mit Salz, Pfeffer und Thymian würzen und Öl darüberträufeln.", order: 2)
        r3.createPreparation(text: "Gemüse im vorgeheizten Backofen bei 220 °C (Umluft 200 °C; Gas: Stufe 3) 35–45 Minuten backen.", order: 3)
        r3.createPreparation(text: "Inzwischen Kräuter waschen, trocken schütteln und Blättchen abzupfen. Gemüse aus dem Ofen nehmen, Feta darüberbröckeln und mit Kräutern bestreuen.", order: 4)
        
        let r4 = Recipe.create(name: "Kartoffel-Radieschen-Salat", intro: "Der Salat lässt sich auch super schon am Vortag zubereiten – zum Beispiel, wenn Sie ihn mit zur Arbeit nehmen möchten. Dann sollten Sie Rucola, Radieschen, Schnittlauch und Rapsöl am besten erst kurz vor dem Verzehr untermengen.", in: context)
        r4.createNutrition(calories: 241, protein: 6, fat: 8, carbs: 33)
        r4.createIngredient(name: "Gemüsebrühe", quantity: 200, unit: "ml")
        r4.createIngredient(name: "Kartoffeln", quantity: 1, unit: "kg")
        r4.createIngredient(name: "Obstessig", quantity: 4, unit: "EL")
        r4.createIngredient(name: "Radieschen", quantity: 250, unit: "g")
        r4.createIngredient(name: "Rapsöl", quantity: 3, unit: "EL")
        r4.createIngredient(name: "Rucola", quantity: 80, unit: "g")
        r4.createIngredient(name: "Schnittlauch", quantity: 10, unit: "g")
        r4.createIngredient(name: "Zwiebel", quantity: 1)
        r4.seasonals = [kartoffeln, radieschen, rucola, zwiebel]
        r4.categories = [glutenfrei, vegetarisch, vegan]
        r4.diets = [.GlutenFree, .Vegetarian, .Vegan]
        r4.createPreparation(text: "Kartoffeln waschen und im Dämpfeinsatz im geschlossenen Topf ca. 30 Minuten gar dämpfen.", order: 1)
        r4.createPreparation(text: "Inzwischen Zwiebel schälen und fein würfeln. Brühe zum Kochen bringen und Zwiebel dazugeben. Vom Herd nehmen und ca. 5 Minuten ziehen lassen. Essig und Senf unterrühren und Marinade mit Salz und Pfeffer abschmecken. Radieschen waschen, putzen und in Scheiben schneiden. Rucola waschen, putzen und trocken schütteln. Nach Belieben etwas kleiner zupfen. Schnittlauch waschen und in Röllchen schneiden.", order: 2)
        r4.createPreparation(text: "Kartoffeln ausdampfen lassen, noch warm pellen und in Scheiben schneiden. Mit der Marinade vermengen und ca. 30 Minuten durchziehen lassen.", order: 3)
        r4.createPreparation(text: "Radieschen, Rucola, Schnittlauch und Öl unter den Salat mengen, nochmal abschmecken und servieren.", order: 4)
        
        let r5 = Recipe.create(name: "Ofenkartoffeln mit Brokkoli", intro: "Die Ofenkartoffeln mit Brokkoli schmecken auch kalt als Salat oder als Snack für die Arbeit und das Büro unwiderstehlich gut.", in: context)
        r5.createNutrition(calories: 471, protein: 16, fat: 29, carbs: 37)
        r5.createIngredient(name: "Brokkoli", quantity: 600, unit: "g")
        r5.createIngredient(name: "Cashewkerne", quantity: 50, unit: "g")
        r5.createIngredient(name: "Cashewmus", quantity: 100, unit: "g")
        r5.createIngredient(name: "Frühlingszwiebel", quantity: 1, unit: "Bund")
        r5.createIngredient(name: "Gartenkresse", quantity: 1)
        r5.createIngredient(name: "Kartoffeln", quantity: 500, unit: "g")
        r5.createIngredient(name: "Olivenöl", quantity: 4, unit: "EL")
        r5.createIngredient(name: "Radieschen", quantity: 0.5, unit: "Bund")
        r5.createIngredient(name: "Rosmarin", quantity: 3, unit: "Zweige")
        r5.createIngredient(name: "Zitronensaft", quantity: 1, unit: "TL")
        r5.seasonals = [brokkoli, fruehlingszwiebel, kartoffeln, radieschen]
        r5.categories = [glutenfrei, vegan, vegetarisch]
        r5.diets = [.GlutenFree, .Vegan, .Vegetarian]
        r5.createPreparation(text: "Brokkoli putzen, waschen, in mundgerechte Röschen schneiden und mit restlichem Olivenöl, Salz und Pfeffer mischen. Brokkoliröschen zu den Kartoffeln geben und in weitere 15 Minuten backen.", order: 1)
        r5.createPreparation(text: "Inzwischen Kresse vom Beet schneiden und mit Zitronensaft und Cashewmus mit einem Stabmixer pürieren; dabei nach und nach Wasser zugießen, bis die Sauce eine cremige Konsistenz hat. Mit Salz, Pfeffer und frisch abgeriebenem Muskat würzen.", order: 2)
        r5.createPreparation(text: "Kartoffeln gründlich abbürsten, waschen und halbieren. Rosmarin waschen, trocken schütteln und Nadeln abzupfen. Alles mit 2 EL Olivenöl, Salz und Pfeffer mischen. Kartoffeln auf ein mit Backpapier ausgelegtes Backblech geben und im vorgeheizten Backofen bei 200°C (Umluft: 180°C; Gas: Stufe 3) etwa 30 Minuten backen.", order: 3)
        r5.createPreparation(text: "Kartoffeln und Brokkoli aus dem Ofen nehmen und auf Tellern anrichten. Cashewsauce darauf verteilen und mit Cashewkernen, Radieschen und Frühlingszwiebeln anrichten.", order: 4)
        r5.createPreparation(text: "Währenddessen Cashewkerne in einer Pfanne 3 Minuten bei mittlerer Hitze anrösten, sodass sie leicht gebräunt sind. Herausnehmen und beiseitestellen. Radieschen putzen, waschen und in feine Stifte schneiden. Frühlingszwiebeln putzen, waschen und in Ringe schneiden.", order: 5)
        
        let r6 = Recipe.create(name: "Pikante Waffeln mit Dip", intro: "Vollkornmehl sättigt durch langkettige Kohlenhydrate und Ballaststoffe nachhaltig. Die Quellstoffe unterstützen eine ausgeglichene Darmflora. Tolle Knöllchen: Dank schwefelhaltiger Öle sowie Vitamin C stärken Radieschen effektiv die körpereigenen Abwehrkräfte.", in: context)
        r6.createNutrition(calories: 623, protein: 24, fat: 37, carbs: 47)
        r6.createIngredient(name: "Apfel", quantity: 0.5)
        r6.createIngredient(name: "Butter", quantity: 100, unit: "g")
        r6.createIngredient(name: "Eier", quantity: 3)
        r6.createIngredient(name: "Feta", quantity: 150, unit: "g")
        r6.createIngredient(name: "Joghurt", quantity: 200, unit: "g")
        r6.createIngredient(name: "Magerquark", quantity: 100, unit: "g")
        r6.createIngredient(name: "Vollkornmehl", quantity: 250, unit: "g")
        r6.createIngredient(name: "Radieschen", quantity: 100, unit: "g")
        r6.seasonals = [apfel, radieschen]
        r6.categories = [backen, vegetarisch]
        r6.diets = [.Vegetarian]
        r6.createPreparation(text: "Für die Waffeln Butter mit 150 g Joghurt, zerbröseltem Feta und Mehl in eine große Schüssel geben. Eier und 50–80 ml Wasser zugeben und Zutaten mit den Quirlen eines Handrührers zu einem glatten Teig verrühren. Teig 5 Minuten quellen lassen. Inzwischen Frühlingszwiebeln putzen, waschen und in Ringe schneiden; das Grün für den Quark beiseitelegen, die weißen Zwiebelringe unter den Teig mischen und diesen mit Pfeffer würzen.", order: 1)
        r6.createPreparation(text: "Für den Dip Apfel putzen, waschen, entkernen und grob raspeln. Radieschen putzen, waschen und in feine Streifen schneiden. Restlichen Joghurt, Quark, Apfel und Radieschen gut verrühren. Das beiseitegelegte Frühlingszwiebelgrün unterheben und den Dip mit Salz und Pfeffer würzen.", order: 2)
        r6.createPreparation(text: "Ein beschichtetes Waffeleisen vorheizen. Teig nochmals durchrühren. Nacheinander etwa 8 Waffeln backen. Dafür je Waffel 2–3 EL Teig auf die untere Backfläche geben und das Waffeleisen schließen. Die Waffel in etwa 4 Minuten goldbraun backen. Fertige Waffeln auf einen Teller geben und mit dem Dip ", order: 3)
        
        let r7 = Recipe.create(name: "Rote Bete mit Radieschen und Walnüssen", intro: "Radieschen enthalten reichlich sekundäre Pflanzenstoffe wie Flavonoide, Glucosinolate und ätherische Öle. Für den scharfen Geschmack sind die Senföle verantwortlich, die antibakteriell, entgiftend, krampflösend und appetitanregend wirken. Der Schafskäse spendet viel knochenstärkendes Calcium und sattmachendes Eiweiß.", in: context)
        r7.createNutrition(calories: 411, protein: 13, fat: 31, carbs: 20)
        r7.createIngredient(name: "Balsamessig", quantity: 2, unit: "EL")
        r7.createIngredient(name: "Feta", quantity: 150, unit: "g")
        r7.createIngredient(name: "Kreuzkümmel", quantity: 0.5, unit: "TL")
        r7.createIngredient(name: "Kardamom", quantity: 0.5, unit: "TL")
        r7.createIngredient(name: "Olivenöl", quantity: 3, unit: "EL")
        r7.createIngredient(name: "Radieschen", quantity: 1, unit: "Bund")
        r7.createIngredient(name: "Rote Bete", quantity: 800, unit: "g")
        r7.createIngredient(name: "Walnusskerne", quantity: 80, unit: "g")
        r7.createIngredient(name: "Zimt", quantity: 1, unit: "Msp")
        r7.seasonals = [radieschen, rotebete]
        r7.categories = [lowcarb, vegetarisch]
        r7.diets = [.Vegetarian]
        r7.createPreparation(text: "Rote Bete putzen, mit geölten Händen oder Einweghandschuhen schälen und in mundgerechte Stücke schneiden. Mit Öl mischen und mit Salz, Pfeffer, Kardamom, Zimt und Kreuzkümmel würzen. In eine Auflaufform geben und im vorgeheizten Backofen bei 200 °C (Umluft: 180 °C; Gas: Stufe 3) 35–40 Minuten backen.", order: 1)
        r7.createPreparation(text: "Inzwischen Walnüsse grob hacken. Radieschen putzen, waschen und je nach Größe ganz lassen oder halbieren bzw. vierteln. Feta zerbröckeln. Kräuter waschen, trocken schütteln und klein hacken.", order: 2)
        r7.createPreparation(text: "Rote Bete aus dem Ofen nehmen und mit Balsamessig beträufeln. Mit Nüssen, Feta, Radieschen und Kräutern bestreut reichen.", order: 3)
        
        let r8 = Recipe.create(name: "Sandwich mit gegrilltem Gemüse", in: context)
        r8.createNutrition(calories: 413, protein: 14, fat: 12, carbs: 60)
        r8.createIngredient(name: "Aubergine", quantity: 2)
        r8.createIngredient(name: "Basilikum", quantity: 3, unit: "EL")
        r8.createIngredient(name: "Ciabatta", quantity: 2)
        r8.createIngredient(name: "Lollo Rosso", quantity: 1)
        r8.createIngredient(name: "Olivenöl", quantity: 4, unit: "EL")
        r8.createIngredient(name: "Paprika", quantity: 2)
        r8.createIngredient(name: "Zucchini", quantity: 2)
        r8.seasonals = [aubergine, paprika, lollorosso, zucchini]
        r8.categories = [vegetarisch]
        r8.diets = [.Vegetarian]
        r8.createPreparation(text: "Die Auberginen und Zucchinis waschen und in Scheiben schneiden. Die Paprika ebenfalls waschen, halbieren, von den Kernen und weißen Innenwänden befreien und in Streifen schneiden. Den Salat verlesen, waschen, trocken schleudern und in mundgerechte Stücke zupfen.", order: 1)
        r8.createPreparation(text: "In einer Grillpfanne 2 EL Öl erhitzen und das Gemüse nacheinander 3-5 Minuten unter Wenden grillen. Herausnehmen, auf einem Küchenkrepp abtropfen lassen und mit Salz und Pfeffer würzen.", order: 2)
        r8.createPreparation(text: "Die Ciabatta im vorgeheizten Ofen 3-4 Minuten anrösten. Herausnehmen, kurz auskühlen lassen, halbieren, aufschneiden und die eine Hälfte mit dem Salat und dem gegrilltem Gemüse belegen, mit Basilikumblättern bestreuen und mit etwas Olivenöl beträufeln. Die 2 Brothälfte daraufklappen und in Servietten gewickelt servieren.", order: 3)
        
        let r9 = Recipe.create(name: "Sommerrollen-Bowl mit asiatischem Gurkensalat", intro: "Diese bunte Bowl bietet eine ganze Menge Vitamine, gesunde Fette und Mineralstoffe! Avocado liefert dem Körper wichtige Omega-3-Fettsäuren, die u.a. den Cholesterinspiegel senken können. Radieschen versorgen den Körper zudem mit B-Vitaminen, Kalium, Eisen und Magnesium und Mango liefert reichlich Vitamin C und Provitamin A.", in: context)
        r9.createNutrition(calories: 326, protein: 9, fat: 13, carbs: 41)
        r9.createIngredient(name: "Agavendicksaft", quantity: 4, unit: "TL")
        r9.createIngredient(name: "Avocado", quantity: 1)
        r9.createIngredient(name: "Chilischote", quantity: 1)
        r9.createIngredient(name: "Erdnusskerne", quantity: 450, unit: "g")
        r9.createIngredient(name: "Limette", quantity: 1)
        r9.createIngredient(name: "Mango", quantity: 1)
        r9.createIngredient(name: "Minze", quantity: 2, unit: "Stiele")
        r9.createIngredient(name: "Mungobohnensprossen", quantity: 80, unit: "g")
        r9.createIngredient(name: "Möhre", quantity: 4)
        r9.createIngredient(name: "Radieschen", quantity: 6)
        r9.createIngredient(name: "Reisessig", quantity: 4, unit: "EL")
        r9.createIngredient(name: "Reisnudeln", quantity: 50, unit: "g")
        r9.createIngredient(name: "Gurke", quantity: 1)
        r9.createIngredient(name: "Sesam", quantity: 10, unit: "g")
        r9.createIngredient(name: "Sojasoße", quantity: 5, unit: "EL")
        r9.createIngredient(name: "Spinat", quantity: 100, unit: "g")
        r9.seasonals = [moehre, radieschen, gurke, spinat]
        r9.categories = [lowcarb, vegan, vegetarisch, glutenfrei]
        r9.diets = [.Vegan, .Vegetarian, .GlutenFree]
        r9.createPreparation(text: "Alle vorbereiteten Zutaten in 4 Schalen verteilen, Kräuter und Dressing unterheben. Erdnüsse grob hacken, Limette vierteln, ebenfalls portionsweise in die Schalen geben und mit Gurkensalat servieren.", order: 1)
        r9.createPreparation(text: "Für den Gurkensalat Gurke waschen und in sehr feine Scheiben schneiden. Wasser mit den Händen aus der Gurke drücken. 2 TL Agavendicksaft, 1 EL Sojasauce und 2 EL Reisessig mischen, Gurke und Sesam unterheben. In 4 kleine Schüsseln geben.", order: 2)
        r9.createPreparation(text: "Minze waschen, trocken schütteln, Blätter grob hacken. Für das Dressing Chilischote längs halbieren, entkernen, waschen, hacken und mit restlichem Essig, Agavendicksaft und restlicher Sojasauce mischen.", order: 3)
        r9.createPreparation(text: "Möhren schälen und in feine Stifte schneiden. Mango schälen, Fruchtfleisch vom Kern lösen und würfeln. Avocado halbieren, entkernen, Fruchtfleisch aus der Schale heben, in Würfel schneiden. Sprossen und Limette waschen und trocknen.", order: 4)
        r9.createPreparation(text: "Nudeln nach Packungsanleitung in kochendem Salzwasser bissfest garen; mit kaltem Wasser ab- schrecken. Inzwischen Spinat und Radieschen putzen und waschen, Radieschen in Scheiben schneiden.", order: 5)
        
        
        let user = User.create(name: "Lisa", email: "lisa@mail.com", password: "test", in: context)
        let collection = Collection.create(name: "April Favoriten", user: user, recipes: Set([r1, r3, r6]), in: context)
    }
}
