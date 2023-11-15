# Övningar

## Skapa tabeller

### 1.1 (Easy)

Du ska skapa databasen för ett bibliotek. Du får själv välja lämpliga datatyper.

1. Börja med att skapa tabellen:

```
authors(_author_id_, author_name)
```

2. Skapa nu tabellen:

```
books(_isbn_, title, author_id, genre)
    author_id --> authors.author_id
```

3. Biblioteket vill nu utöka databasen för att hantera utlåningar av böcker, hjälp dem genom att skapa dessa tabeller! Lägg gärna till lämpliga constraints i dina nya tabeller.

### 1.2 (Medium)

Här är ett utkast till ett schema för databasen till ett online-rollspel. Den saknar för tillfället primary keys och andra constraints.

```
players(name, level, money)
items(id, itemname, value)
equippable(id, equipslot)
player_inventory(player, item)
equipped(player, item, equipslot)

```

**players** innehåller användarnamn, level och in-gamepengar för alla spelare.

**items** beskriver alla föremål som spelare kan hitta i spelet. Varje föremål har ett ID-nummer, ett namn (flera föremål kan ha samma namn) och ett monetärt värde.

**equippable** beskriver ytterligare en delmängd av föremål som kan bäras av spelare. Varje sådant föremål har en _equipslot_ (t.ex. ”ring”, ”vapen”, ”hjälm” eller liknande) som indikerar var spelare kan ta på sig föremålet.

**player_inventory** visar de föremål som alla spelare bär på (ej föremål som spelaren har på sig just nu). Om spelare har på sig en hjälm just nu syns den alltså inte här.

**equipped** innehåller föremålen som alla spelare har på sig just nu, observera att en spelare kan bära högst ett föremål i varje _equipslot_.

1. Din första uppgift är att lägga till meningsfulla primary keys och constraints. Förutom att se till att föremål verkligen existerar osv. bör du se till att en spelare inte kan utrusta flera föremål i samma _equipslot_ och förhindra spelare från att utrusta föremål i fel _equipslot_. Se också till att alla monetära värden är icke-negativa.

   Tips: Cirka fem constraints är lämpliga för denna uppgift.
   Tips: Kolla in CHECK och UNIQUE

2. Skapa databasen via `CREATE TABLE`-statements.

3. Nu ska du sätta in data i din tabell. Skriv INSERT-statements för tabellen med dessa data (lägg till saknade värden vid behov):
   - Ett föremål med namnet "Vorpal sword", värt 10 000 och som utrustas som _weapon_.
   - Ett föremål som inte går att ta på sig med namnet "Java direkt med Swing" värt 542.
   - Ett föremål med namnet "Databaser: Den kompletta boken" värt 495 och som utrustas som _weapon_.
   - Ett föremål med namnet "Ugnsvantar", värt 999 och utrustas som _gloves_.
   - En användare med namnet "kristian" som är level 100, bär det mäktiga Vorpal Sword och har "Databaser: Den kompletta boken" och "Ugnsvantar" i sitt inventory.
   - En användare med namnet "thomas" som är level 2, bär ”Ugnsvantar” och har "Databaser: Den kompletta boken" i sitt inventory.
4. Testa dina constraints. Skriv INSERTS för var och en av följande åtgärder, de bör alla misslyckas om du har implementerat dina constraints korrekt.
   - Att utrusta "Java direkt med Swing" som Kristians weapon (ej utrustningsbart).
   - Att utrusta "Databaser: Den kompletta boken" som Kristians helmet (fel slot).
   - Att utrusta "Databaser: Den kompletta boken" som Kristians weapon (han har redan ett vapen).
   - Skapa en annan användare med namnet "kristian".

## Queries

### 2.1 (Easy)

Inför den här övningen kommer du att behöva köra två SQL-filer som finns tillgängligt under lektion 1 på LearnPoint.

Skriv en query som returnerar...

1. all information från tabellen `employees`
2. förnamn, efternamn, telefonnummer och email från `employees`
3. förnamn, efternamn och lön på alla employees med lön högre än 10000, sortera på lön i fallande ordning
4. förnamn och efternamn på alla anställda med
   employees som har managern Nancy Greenberg
5. förnamn och efternamn på alla anställda som inte lagt in sitt telefonnummer i databasen
6. förnamn och efternamn på alla anställda vars namn slutar på "..son" (exempelvis Johnson)
7. **[Medium]** förnamn och efternamn på alla managers. Tips: Skapa en view först.

### 2.2 (Easy - Hard)

Använd domänen från övning 1.2.

Skriv nu följande queries av olika svårighetsgrad:

- Lista hela inventory för spelaren ”kristian”.
- Hitta det genomsnittliga värdet för alla föremål i spelet.
- Hitta för varje föremål antalet spelare som bär det i sitt _inventory_. Resultatet bör innehålla två kolumner, en för föremåls-ID och en för antal spelare. Se till att visa 0 för föremål som ingen har i sitt _inventory_.
- Hitta för varje spelare namnet på nuvarande weapon eller strängen "Inget" om spelaren inte har något weapon. Resultatet bör ha kolumner för spelarnamn och föremålsnamn.
- Hitta namnet på alla föremål med ett värde av minst 500 och som är utrustade av minst en spelare med en level över 75.
- Hitta för varje spelare det totala kombinerade värdet av alla föremål de har på sig och som de har i sitt _inventory_. Resultatet bör ha två kolumner, en för spelarnamn och en annan för totalt värde. Spelare som inte har några föremål behöver inte finnas med i resultatet.
- Hitta alla föremål i Thomas inventory som han kan ta på sig direkt. Det innebär att föremålet måste gå att ta på sig i en av Thomas lediga slots. En hjälm ska alltså inte finnas med i resultatet om Thomas redan bär på en hjälm. Resultatet bör ha två kolumner, id och equipslot

### 2.3 (Medium)

https://leetcode.com/problems/find-total-time-spent-by-each-employee/

### 2.4 (Medium)

https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/

### 2.5 (Easy)

a) Hitta de totala lönerna uppdelat på avdelning i tabellen `employees`.
b) Hitta den genomsnittliga lönen på hela företaget.
c) Hitta personen med högst lön på varje avdelning.

### 2.6 (HARD)

USAs röstningssystem bygger på att varje delstat har ett visst antal elektorer, och kandidaten som har flest röster i delstaten får alla rösterna från elektorerna. Den med flest röster från elektorer vinner sedan valet. Kolla upp detta på internet om du är lite osäker inför uppgiften.

1. Skapa en tabell

```
state_votes(_state_code_, biden_votes, trump_votes, electors)
```

och sätt in lite fiktiv data.

2. Skapa en view `state_results` med en kolumn med statens kod, en med den vinnande presidentkandidaten, och en sista med antalet elektorer som kandidaten har vunnit. Tips: kolla in `CASE`.

3. Skriv en query som slutligen visar hur många totala röster varje kandidat har fått.

4. Byt nu tabellen till:

```
state_votes(_state_code_, _candidate_, votes, electors)
```

Gör om uppgift 2 och 3 med den nya tabellen. Tips: kolla in `RANK()` och andra window-functions.

Vilken struktur är bäst anser du? Finns det några för och nackdelar?


### 2.7 (Medium)
https://leetcode.com/problems/bank-account-summary-ii/

### 2.8 (Hard)
https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/

### 2.9 (Easy)
https://www.w3schools.com/sql/exercise.asp
