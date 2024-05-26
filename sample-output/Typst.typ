// Some definitions presupposed by pandoc's typst output.
#let horizontalrule = [
  #line(start: (5%,0%), end: (95%,0%), stroke: (paint: gray, thickness: 4pt, cap: "round"))
]

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

#set table(
  inset: 6pt,
  stroke: none
)

#let conf(
  title: none,
  authors: (),
  affiliations: (),
  keywords: (),
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.75cm, y: 2cm),
  paper: "a4",
  lang: "en",
  region: "GB",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  doc,
) = {
  set document(
    title: title,
    author: authors.map(author => author.name),
    keywords: keywords,
  )
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none and authors != [] {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      column-gutter: 1.25em,
      ..authors.map(author =>
          align(center)[
            #strong[#emph[#author.name]]
            #if "affiliation" in author [
              \ #text(size: 0.7em)[#emph[#author.affiliation]]
            ]
            #if "email" in author [
              \ #text(size: 0.7em)[#underline[#author.email]]
            ]
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if affiliations.len() > 0 {
    set text(size: 9pt)
    block(width: 100%, stroke: none, inset: (top: 20pt, bottom: 20pt), {
      text(weight: "semibold", "Affiliations:")
      parbreak()
      affiliations.map(affiliation => {
        super(affiliation.id)
        h(1pt)
        affiliation.name 
        parbreak()
      }).join("")
    })
  }

  if abstract != none {
    block(inset: (left: 2em, right: 2em))[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if (keywords.len() > 0) {
    text(size: 9pt, {
      h(2em)
      text(weight: "semibold", "Keywords")
      h(8pt)
      keywords.join(", ")
    })
  }
  v(10pt)

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
#show: doc => conf(
  title: [A Typst Compiler Test],
  authors: (
    ( name: "Jane Doe",
      affiliation: "The International Affiliated Institute of Ur,
Uristan 54321",
      email: "jane\@doe.org" ),
    ( name: "John Doe",
      affiliation: "The Most Esteemed University of Ir, Department of
Arology, Aristan 200041",
      email: "" ),
    ),
  abstract: [#strong[#emph[Observe that we use Scrivener Styles (this is
strong emphasis)];];; working with Styles affords us maximum flexibility
to both visualise the text in the editor and transform it via the
compiler for multiple outputs. #smallcaps[Re teng thu];ng;Thung kurnap
fli rintax ti nalista gra athran epp. Er #link(<section-c>)[lamax] berot
cree dri. La, morvit urfa quolt… er prinquis, pank obrikt quolt gen ma
dri tharn athran relnag xi erc wex velar. Thung ik la flim urfa su ewayf
thung. Berot wynlarce—#strong[gen nix srung athran] er vusp gen, sernag
jince. Ma er ma jince ma rintax ma wex ux wynlarce. Xu, zeuhl lydran ux
erk. #underline[Sernag epp anu er cree ik korsa groum rintax] velar
ozlint velar thung vo korsa berot menardis er arul.

],
  margin: (x: 2cm,y: 4cm,),
  paper: "a4",
  font: ("Alegreya",),
  fontsize: 12pt,
  sectionnumbering: "1.1.1",
  cols: 1,
  doc,
)

// Import some packages
#import "@preview/gentle-clues:0.8.0": info, warning, error, example, tip
#import "@preview/in-dexter:0.3.0": *
#set heading(numbering: "I.a")
#set text(font: "Alegreya Sans", size: 14pt, discretionary-ligatures: true, number-type: "old-style")
#set par(leading: 0.85em, justify: true)
#show figure.caption: it => [
  #set text(font: "Alegreya", size: 12pt, discretionary-ligatures: false, number-type: "lining")
  #emph[#it.supplement~#it.counter.display(it.numbering) — #it.body]
]
#show heading.where(level:1): it=> [#pagebreak() #it]

#outline(
  title: auto,
  depth: 3
);

= Red Book
<red-book>
== section a
<section-a>
#rotate(5deg)[This text should be angled 5° in Typst. ]

#smallcaps[Re teng thung] #index[Thung]zeuhl la, ti dri. Relnag xi
nalista dri lydran wynlarce, prinquis zorl nalista, zeuhl re obrikt
relnag erk wynlarce wex pank #link(<section-f>)[gronk];?
`Menardis clum`, morvit xu ma yem twock irpsa ma cree tolaspa. Erk teng
flim obrikt; #emph[menardis nix frimba tharn nalista kurnap rhull];.

#info[This info box comes from the gentle-clues package that is imported by the meta-data headers above. #lorem(10)]
#smallcaps[Re teng thung];; kurnap fli rintax ti nalista gra athran epp.
Er lamax berot cree dri. La, morvit urfa quolt… er prinquis, pank obrikt
quolt gen ma dri tharn athran relnag xi erc wex velar (Crivellato &
Ribatti, 2007; Barrett & Simmons, 2015). Thung ik la flim urfa su ewayf
thung. Berot wynlarce—gen nix srung athran er vusp gen, sernag jince. Ma
er ma jince ma rintax ma wex ux wynlarce. Xu, zeuhl lydran ux erk.
#underline[Sernag epp anu er cree ik korsa groum rintax] velar ozlint
velar thung vo korsa berot menardis er arul (Hoffman & Prakash, 2014).
We can use native cross-referencing, see @fig-one, but for this we
#strong[must] use the `typstFix.lua` filter. This allows `fig-` `tbl-`
`eq-` and `sec-` prefixes to not be considered as Pandoc#index[Pandoc]
citations#index[Citations]. Note below the figure is the Typst label,
there #strong[must] be a newline between the caption and the label.

#figure(image("xkcd.png"),
  caption: [
    This figure uses the Scrivener convention of embedded
    figure+caption. For Pure Typst we #strong[must] ensure figures are
    followed by a caption style (see the compiler format for details).
    #index("Programs", "Scrivener")
  ]
)

<fig-one> #index[Figure]

Erk ik lydran dri yem groum athran furng xi, groum ma… sernag gen vusp
zorl cree tolaspa arul furng gronk morvit, gen re kurnap tolaspa twock
furng ma epp. Ewayf morvit rintax urfa wynlarce pank dwint zorl velar
zeuhl? Ux srung urfa lydran athran menardis; yem sernag ju cree anu ux
wynlarce thung. Qi obrikt; brul teng zeuhl wex, yiphras dri jince erk la
kurnap. Dri korsa… brul prinquis gra twock yem ewayf lydran furng, dwint
lamax, qi urfa su zorl gronk furng erk irpsa lydran ik.#footnote[Kurnap
ik lydran kurnap brul?] Er urfa thung morvit helk srung tolaspa er urfa
groum, gronk brul nix vo; ti gen sernag velar. Rintax arul flim groum
ma; gen delm zorl nix arka erk? Qi su flim#footnote[standard footnote];,
gronk irpsa qi ik anu brul berot morvit; ux erc whik (Copenhaver, 2014).

@fig-icon shows an icon and native Typst referencing. Icons are visual representations.

#figure(
  image("xkcd.png", width: 60%),
  caption: [A figure specified using pure Typst and therefore dropped by HTML-based outputs like Prince. The benefit is we can directly Typst cross-referencing to the figure without needing any filters etc.])  <fig-icon>  
Rintax arka lydran kurnap#index[Kurnap, see Thung], ti re, vo athran
obrikt zorl. Wynlarce yiphras… fli menardis pank athran lydran. Tharn
groum arka cree, urfa clum; flim velar fli delm lydran. La athran velar
ti arka gronk fli irpsa prinquis ju ozlint sernag, erk nix morvit xi
ozlint srung? The length of "Hello" is #"hello".len() characters long.

- This is a Scrivener#index[Scrivener] List, it will only work in
  Pandoc-based compiles. #index("Programs", "Pandoc")
- Two
- Three

Furng dri wynlarce re epp, korsa obrikt cree pank qi tharn thung furng
fli (Siegel & Silins, 2015). Lamax delm… brul re, arka ik prinquis re,
fli qi cree jince flim er, urfa erk, anu ma jince erc athran? Dwint, anu
urfa; srung ju gra, su erk, zeuhl epp thung whik xu furng berot. Delm
lamax ux lamax frimba groum pank jince ux, lamax fli gronk qi delm ux?
Vusp lamax, arka nalista berot flim, brul prinquis; anu nix xu, brul
gronk nix korsa dri ti furng frimba berot arul.

// This is a Comment. It should be converted into the correct format for either Typst or HTML using a raw block in the source but the text should not be visible in the output PDF…
Relnag sernag arul; zorl ma ux flim ma wex yiphras prinquis, ti obrikt
twock. Irpsa groum xu frimba re irpsa harle quolt velar ewayf teng,
korsa tharn srung re lamax. Srung nalista; groum ma erc, erk la gra
prinquis vusp fli vusp frimba lydran vo urfa teng berot ju quolt. Athran
xi, gen velar srung; lydran su zeuhl fli jince su xu fli. Ma vo whik
arka teng nix ozlint vusp pank. Zeuhl srung; ma urfa epp xi urfa lydran
velar gen vo arul kurnap wex ozlint thung. Er ik flim. Zeuhl galph, delm
wex gra, lydran athran menardis clum wynlarce; quolt xi, menardis delm
lydran morvit korsa, yem nix. Cree su erk yem anu… wynlarce teng erk
prinquis harle, arul dri ma kurnap ma qi helk ti er srung helk nix twock
(Simmons, 2015).

Arka kurnap su flim… helk nix, rhull thung su arul pank, lamax erc korsa
tharn menardis, ma frimba dwint flim? Nalista korsa yem dwint er vusp
dwint athran… re yiphras morvit berot groum dri, ju su teng su zorl.
Ewayf gen… su flim vo ma menardis berot, er ti.#footnote[Urfa frimba ju
wynlarce, zeuhl anu quolt—erc pank quolt ju ik lamax, rintax vusp wex
srung pank la berot vusp ozlint dri zeuhl berot qi zorl brul thung.] Ik
srung; zeuhl thung morvit nalista xi ju xi cree ti sernag anu brul.
Harle berot frimba galph relnag wynlarce gra. Lydran ma sernag ti zorl
ju yiphras, anu kurnap clum rhull; twock dwint, la berot ti la zorl erc
galph ti nix er. Jince gen rintax gen fli, wex su clum; vusp teng jince
furng. Vusp sernag su re—thung brul twock lamax yem gra arka vusp la
rintax erk. Ma wex velar clum; ewayf, athran sernag, nalista re whik
menardis dwint vusp thung morvit twock pank anu dwint ju clum berot.

#lorem(150) #index("Typst", "Lorum")

== section b
<section-b>
Furng lamax yem, pank lydran, ux cree? Galph whik, lydran ma su anu
galph tharn nix, dwint su dwint kurnap vusp—tharn twock yem srung
nalista dri. Zeuhl gronk athran arka helk tharn ozlint yiphras. Quolt xi
pank su er, rintax la wex menardis xi urfa. Arul epp; clum nalista nix
zorl helk, urfa ewayf flim zeuhl anu athran qi thung la. Zorl pank jince
thung nix nalista srung ma ewayf korsa gronk—yiphras obrikt korsa vo
arka erc vusp.

The following is #strong[LaTeX maths] (wrapped in a Maths Block
style#index[Maths]) and is #strong[only] supported by
Pandoc#index[Pandoc] intermediates (for Pure Typst#index[Typst] compiles
it will just compile as code):

$ frac(d, d x) (integral_a^x f (u) thin d u) = f (x) . $

For Typst native maths#index[Maths], we can wrap in a raw typst style so
it should get rendered by Typst (note we need to explicity use the
dollar sign):

$ sum_(k=0)^n k
    &= 1 + ... + n \
    &= (n(n+1)) / 2 $
Ma obrikt, la; rhull brul kurnap arul pank athran, arul su ma? Clum
quolt, rhull quolt obrikt frimba teng furng velar, qi er
kurnap#index[Kurnap, see Thung] cree su tolaspa athran, arka qi
menardis? Nix qi sernag ti ewayf ju su relnag frimba pank dwint.
Prinquis, menardis arul… delm ju zeuhl nalista srung, wynlarce zorl
obrikt brul yem furng tolaspa tharn ju er sernag er. Delm erc yiphras
clum, gra srung arka.

The following is a raw typst#index[Typst] table (see
#strong[@tbl-raw1];): #index[Table]

#figure(
  caption: [Raw Typst Table],
  table(
  columns: (1fr, auto, auto),
  inset: 10pt,
  align: horizon,
  [], [*Area*], [*Parameters*],
  [Some Text],
  $ pi h (D^2 - d^2) / 4 $,
  [
    $h$: height \
    $D$: outer radius \
    $d$: inner radius
  ],
  [More Text],
  $ sqrt(2) / 12 a^3 $,
  [$a$: edge length]
))  <tbl-raw1>  
Urfa, ju ozlint srung twock kurnap urfa fli, kurnap; cree vusp urfa
jince sernag su qi prinquis ozlint flim wex anu tolaspa gra. Nix anu fli
korsa su irpsa er velar, ju… flim furng erk teng dri berot, galph tharn
rhull, ti ozlint erk kurnap? Twock, nalista tolaspa zeuhl ux, tharn
thung#index[Thung]… clum berot ma. Arul athran ewayf quolt yem menardis
la nix arka. Tharn epp galph prinquis menardis; nalista rintax. Irpsa
quolt morvit; ti clum cree, athran flim irpsa twock.

Su ewayf delm helk nalista yiphras, su ma epp xu… anu ik cree dwint
rintax brul sernag cree wynlarce obrikt nalista. Frimba yiphras
menardis, ozlint wynlarce morvit er delm, fli whik, er irpsa ik srung
whik, flim—furng prinquis furng. Gra arul, yiphras er gen; furng morvit,
whik ik er nix su fli. Groum menardis pank su ewayf berot srung zeuhl
morvit ewayf urfa zorl ux… zeuhl srung. Fli twock la anu fli whik obrikt
arka galph ma clum su er, erc; thung#index[Thung] urfa ux er frimba la
lydran twock. Vusp morvit; xu erc, tharn fli whik lamax su, ma teng
twock ma groum.

Korsa ik su prinquis berot ti flim galph irpsa korsa whik erc lamax ju
erk obrikt er. Ik, er ik morvit re erk clum; ux fli. Erc prinquis berot
srung zeuhl ju la nalista yem su, zeuhl ik irpsa vusp tolaspa jince
srung. Er ux prinquis morvit rintax ti; xi, ewayf xi. Quolt erk srung…
relnag su twock epp menardis jince gronk galph, su frimba ik jince, ti
la xu quolt, teng rintax. Velar zeuhl cree korsa, dwint helk su groum
athran zeuhl morvit; sernag ik cree, yem er menardis prinquis. Re groum,
er epp su frimba su ewayf. Tharn ma, ti thung#index[Thung] wex; relnag
urfa menardis furng zorl urfa ik galph. La jince, sernag teng—urfa, xu
anu ma xu er vo frimba dri wynlarce groum?

#lorem(150) #index("Typst", "Lorum")

#pagebreak()

= Black Book
<black-book>
== section c
<section-c>
Brul tolaspa prinquis, cree—ju, su gra, ozlint gen jince fli zorl, ti qi
cree, gronk vusp wex. Tolaspa ux wynlarce athran irpsa vo lydran lamax
erk delm tharn re tharn kurnap menardis. Er gen dwint? Lydran lamax clum
menardis twock rhull ozlint ma arka epp delm? Dri morvit galph gra. Dri
erk; ozlint gen groum helk ozlint furng jince, groum er. Teng ux furng
fli morvit ewayf su helk delm vusp lamax, pank wex morvit erk athran
obrikt. Su lamax; ti rhull, prinquis nalista er kurnap cree morvit ju
helk wex srung, yiphras dwint. Relnag, galph—zorl, ik menardis nalista
su athran, er ju dri kurnap harle xu gronk qi rintax prinquis ik. Arul
irpsa pank; ozlint urfa vo rintax wynlarce, groum srung er, su ik
prinquis, delm gen berot yem twock erk obrikt re.

#figure(image("xkcd.png"),
  caption: [
    Scrivener embedded figure + Caption style, also note the styled
    label below for cross-referencing. #index[Scrivener]
  ]
)

<fig-icona> #index[Figure]

See #strong[@fig-icona];. Irpsa helk ozlint, su arka brul rhull dwint
tharn. Frimba ewayf fli tharn dwint arul vo, twock erk korsa groum
erc—lydran teng. Dri er korsa srung ti, tolaspa gen, morvit nix athran
morvit vusp. Velar brul ma gen brul velar ju zeuhl, ik erc
gen.#footnote[Yiphras clum xu dwint zorl, xi gronk, ma yem xi delm irpsa
tolaspa.] Srung su, sernag zorl re ik yiphras irpsa gra berot, sernag
frimba. Yem harle flim epp yem.

Brul vo athran rhull xu re yiphras fli re vo su korsa frimba harle.
Nalista arul erk nalista kurnap—lamax zorl pank wynlarce zeuhl kurnap,
athran ozlint zeuhl yem. Furng obrikt nix zorl er re; ju velar ozlint
wynlarce. Srung ti dwint urfa flim; menardis cree irpsa zeuhl menardis
obrikt teng vusp morvit ju frimba obrikt flim, qi xu. Galph furng lydran
su xu, ti twock ma; arul frimba lamax yiphras zeuhl relnag quolt tolaspa
kurnap obrikt harle, korsa wynlarce. Velar morvit cree re korsa nalista,
brul tolaspa delm su erk la yiphras groum korsa, urfa xi nalista fli
obrikt erc. Frimba ma vusp gronk, zorl twock berot xi brul yiphras ma
groum.

#figure(
  align(center)[#table(
    columns: (16.67%, 33.33%, 50%),
    align: (left,center,right,),
    table.header([Title 1], [Title 2], [Title 3],),
    table.hline(),
    [Baubel], [Dawdle], [Maudle],
    [Dribble], [Drubble], [Drabble],
    [Baubel], [Dawdle], [Maudle],
    [Dribble, Drabble], [Drubble, Dribble], [Drabble, Drubble],
  )]
  , caption: [This is a table caption. The source is a custom list-table
  that uses a Pandoc filter, then converted to the Typst equivalent.
  This will not work in pure typst, but be shown as code.]
  , kind: table
  )

<tbl-list> #index[Table]

Ma tharn ewayf lamax kurnap#index[Kurnap, see Thung] vo gronk arul,
berot brul lydran xu, nix srung wynlarce whik athran, su harle arka zorl
gen—helk harle erk, teng re, helk nix galph? Frimba jince berot galph
re; ju lamax la srung kurnap frimba? Er re ewayf gen rhull rintax srung;
erk arul, flim tolaspa rhull, korsa dwint tolaspa arul er ma. Lamax ik
dri, rintax er rintax… delm zorl urfa ma helk prinquis ozlint jince zorl
erk rintax. Vusp velar; su cree berot la ewayf. Whik, tolaspa qi; gronk
dwint tharn pank re xi prinquis arka qi xi berot ma ux ma athran. Xu qi;
ux galph gen arul la zeuhl ux lamax irpsa, menardis vo berot gra furng
twock teng arka prinquis lamax zorl.

Ma athran flim ewayf brul menardis, su tolaspa. Ju su nalista; qi ma
morvit. Su ma arka quolt berot, velar tolaspa srung tolaspa galph
ozlint. Nix prinquis relnag irpsa tolaspa ewayf er re su erk korsa. Ma
yem la xi tolaspa quolt xi yem. Delm yiphras relnag fli su korsa fli dri
sernag relnag frimba velar, srung yiphras. Brul menardis brul ux
wynlarce, ozlint; relnag rintax ewayf wex nalista galph. Flim sernag ju
ux… teng vo berot zeuhl helk. Brul, re fli su lamax cree irpsa.

#lorem(150) #index("Typst", "Lorum")

#figure(
  caption: [Section Type Typst Table],
  table(
  columns: (1fr, auto, auto),
  inset: 10pt,
  align: horizon,
  [], [*Area*], [*Parameters*],
  [Some Text],
  $ pi h (D^2 - d^2) / 4 $,
  [
    $h$: height \
    $D$: outer radius \
    $d$: inner radius
  ],
  [More Text],
  $ sqrt(2) / 12 a^3 $,
  [$a$: edge length]
))  <tbl-raw2> #index[Table]

== section d
<section-d>
Whik gronk; thung#index[Thung] epp rintax whik jince dwint srung sernag
nix la quolt sernag brul jince. Twock, quolt whik tharn dri cree gen…
prinquis nix delm velar rhull korsa ti epp su rintax lydran irpsa,
kurnap#index[Kurnap, see Thung] re menardis. Ma ozlint ju wynlarce gronk
ma cree clum la wex frimba zeuhl; velar menardis, wynlarce furng berot
furng gen. Thung#index[Thung] er wynlarce wex tolaspa, srung morvit
galph. Gen athran morvit… korsa, morvit menardis kurnap rintax velar
teng srung vo frimba. Kurnap urfa arka vusp clum thung#index[Thung] ju
erc yem, groum obrikt nalista korsa; dri berot. Groum galph; ik, morvit
ti gronk zeuhl erc nix. Lamax frimba, dri tolaspa helk; arul xi su clum
flim su xu gra, gen urfa groum irpsa.

Ik vusp; er su tolaspa qi thung#index[Thung] sernag velar furng vo.
Berot gronk erc er furng. Jince ma, korsa… er twock, delm sernag velar
galph, whik xi ma menardis rintax xu furng er anu clum. Groum cree su
ewayf—nix xi quolt vusp er dwint sernag kurnap nalista ti, sernag vusp
ju. Rintax dwint la; clum ju tolaspa su whik wex rintax er qi furng,
srung morvit ozlint wex gronk arul. Ozlint lydran, cree athran lamax
obrikt tolaspa, sernag; epp morvit anu prinquis nix xi.

Urfa erc prinquis; tharn yem arka, vusp xu erc. Fli xi menardis arka… ma
whik arka ma fli helk kurnap tolaspa groum thung#index[Thung] furng
groum er su sernag srung erk. Wex zeuhl, dwint rintax; gronk arka velar
berot qi korsa morvit berot cree galph re galph delm
pank.#footnote[Thung cree, furng delm tolaspa; ozlint kurnap ux quolt
obrikt athran twock zorl jince?] Re groum; thung#index[Thung] su flim
kurnap su vo quolt, wex er zorl gen xu ti re. Wynlarce, ti prinquis ux
lamax gen wex, wynlarce er la erk lamax rhull?

Delm vo; berot nix erc twock wynlarce gronk ju? Yem groum whik erk galph
urfa epp; kurnap nalista brul, zeuhl vo. Nalista prinquis dwint er vusp
groum gronk arka whik ik menardis thung#index[Thung] ux, ma brul ewayf;
groum wynlarce galph velar. Qi xi arul; flim, cree yiphras prinquis clum
anu velar yiphras quolt la tharn. La sernag kurnap wynlarce teng vo urfa
helk; berot tharn nalista dri lamax brul vo qi thung#index[Thung]? Galph
wex ma epp, twock relnag berot. Prinquis su rintax; pank whik kurnap,
frimba ma velar, thung#index[Thung] gen rintax erc rintax.

#lorem(150) #index("Typst", "Lorum")

#pagebreak()

= White Book
<white-book>
== section e
<section-e>
Brul tolaspa prinquis, cree—ju, su gra, ozlint gen jince fli zorl, ti qi
cree, gronk vusp wex. Tolaspa ux wynlarce athran irpsa vo lydran lamax
erk delm tharn re tharn kurnap menardis. Er gen dwint? Lydran lamax clum
menardis twock rhull ozlint ma arka epp delm? Dri morvit galph gra. Dri
erk; ozlint gen groum helk ozlint furng jince, groum er. Teng ux furng
fli morvit ewayf su helk delm vusp lamax, pank wex morvit erk athran
obrikt. Su lamax; ti rhull, prinquis nalista er kurnap cree morvit ju
helk wex srung, yiphras dwint. Relnag, galph—zorl, ik menardis nalista
su athran, er ju dri kurnap harle xu gronk qi rintax prinquis ik. Arul
irpsa pank; ozlint urfa vo rintax wynlarce, groum srung er, su ik
prinquis, delm gen berot yem twock erk obrikt re.

#figure(image("xkcd.png"),
  caption: [
    Scrivener embedded figure + Caption style, also note the styled
    label below for cross-referencing. #index("Programs", "Scrivener")
  ]
)

<fig-iconz> #index[Figure]

See #strong[@fig-iconz];. Irpsa helk ozlint, su arka brul rhull dwint
tharn. Frimba ewayf fli tharn dwint arul vo, twock erk korsa groum
erc—lydran teng. Dri er korsa srung ti, tolaspa gen, morvit nix athran
morvit vusp. Velar brul ma gen brul velar ju zeuhl, ik erc
gen.#footnote[Yiphras clum xu dwint zorl, xi gronk, ma yem xi delm irpsa
tolaspa.] Srung su, sernag zorl re ik yiphras irpsa gra berot, sernag
frimba. Yem harle flim epp yem.

Brul vo athran rhull xu re yiphras fli re vo su korsa frimba harle.
Nalista arul erk nalista kurnap—lamax zorl pank wynlarce zeuhl
kurnap#index[Kurnap, see Thung], athran ozlint zeuhl yem. Furng obrikt
nix zorl er re; ju velar ozlint wynlarce. Srung ti dwint urfa flim;
menardis cree irpsa zeuhl menardis obrikt teng vusp morvit ju frimba
obrikt flim, qi xu. Galph furng lydran su xu, ti twock ma; arul frimba
lamax yiphras zeuhl relnag quolt tolaspa kurnap obrikt harle, korsa
wynlarce. Velar morvit cree re korsa nalista, brul tolaspa delm su erk
la yiphras groum korsa, urfa xi nalista fli obrikt erc. Frimba ma vusp
gronk, zorl twock berot xi brul yiphras ma groum.

#lorem(150) #index("Typst", "Lorum")

== section f
<section-f>
Whik gronk; thung#index[Thung] epp rintax whik jince dwint srung sernag
nix la quolt sernag brul jince. Twock, quolt whik tharn dri cree gen…
prinquis nix delm velar rhull korsa ti epp su rintax lydran irpsa,
kurnap re menardis. Ma ozlint ju wynlarce gronk ma cree clum la wex
frimba zeuhl; velar menardis, wynlarce furng berot furng gen.
Thung#index[Thung] er wynlarce wex tolaspa, srung morvit galph. Gen
athran morvit… korsa, morvit menardis kurnap rintax velar teng srung vo
frimba. Kurnap urfa arka vusp clum thung#index[Thung] ju erc yem, groum
obrikt nalista korsa; dri berot. Groum galph; ik, morvit ti gronk zeuhl
erc nix. Lamax frimba, dri tolaspa helk; arul xi su clum flim su xu gra,
gen urfa groum irpsa.

Ik vusp; er su tolaspa qi thung#index[Thung] sernag velar furng vo.
Berot gronk erc er furng. Jince ma, korsa… er twock, delm sernag velar
galph, whik xi ma menardis rintax xu furng er anu clum. Groum cree su
ewayf—nix xi quolt vusp er dwint sernag kurnap nalista ti, sernag vusp
ju. Rintax dwint la; clum ju tolaspa su whik wex rintax er qi furng,
srung morvit ozlint wex gronk arul. Ozlint lydran, cree athran lamax
obrikt tolaspa, sernag; epp morvit anu prinquis nix xi.

#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.header([Red], [Black], [White],),
    table.hline(),
    [A], [B], [C],
    [D], [E], [F],
  )]
  , caption: [This is a Scrivener table]
  , kind: table
  )

<tbl-scriv> #index[Table]

Urfa erc prinquis; tharn yem arka, vusp xu erc. Fli xi menardis arka… ma
whik arka ma fli helk kurnap tolaspa groum thung#index[Thung] furng
groum er su sernag srung erk. Wex zeuhl, dwint rintax; gronk arka velar
berot qi korsa morvit berot cree galph re galph delm
pank.#footnote[Thung cree, furng delm tolaspa; ozlint kurnap ux quolt
obrikt athran twock zorl jince?] Re groum; thung#index[Thung] su flim
kurnap#index[Kurnap, see Thung] su vo quolt, wex er zorl gen xu ti re.
Wynlarce, ti prinquis ux lamax gen wex, wynlarce er la erk lamax rhull?

Delm vo; berot nix erc twock wynlarce gronk ju? Yem groum whik erk galph
urfa epp; kurnap nalista brul, zeuhl vo. Nalista prinquis dwint er vusp
groum gronk arka whik ik menardis thung#index[Thung] ux, ma brul ewayf;
groum wynlarce galph velar. Qi xi arul; flim, cree yiphras prinquis clum
anu velar yiphras quolt la tharn. La sernag kurnap wynlarce teng vo urfa
helk; berot tharn nalista dri lamax brul vo qi thung#index[Thung]? Galph
wex ma epp, twock relnag berot. Prinquis su rintax; pank whik kurnap,
frimba ma velar, thung#index[Thung] gen rintax erc rintax.

#lorem(150) #index("Typst", "Lorum")

#pagebreak()

= Bibliography
<bibliography>
#block[
#block[
Barrett, L & Simmons, W (2015) “Interoceptive predictions in the brain”
#emph[Nature Reviews Neuroscience] #strong[16];, 419–429
#link("https://doi.org/10.1038/nrn3950")[10.1038/nrn3950]

] <ref-barrett2015>
#block[
Copenhaver, R (2014) “Berkeley on the language of nature and the objects
of vision” #emph[Res Philosophica] #strong[91];, 29–46
#link("https://doi.org/10.11612/resphil.2014.91.1.2")[10.11612/resphil.2014.91.1.2]

] <ref-copenhaver2014>
#block[
Crivellato, E & Ribatti, D (2007) “Soul, mind, brain: Greek philosophy
and the birth of neuroscience” #emph[Journal of Anatomy] #strong[71];,
327–336
#link("https://doi.org/10.1016/j.brainresbull.2006.09.020")[10.1016/j.brainresbull.2006.09.020]

] <ref-crivellato2007>
#block[
Hoffman, DD & Prakash, C (2014) “Objects of consciousness”
#emph[Frontiers in Psychology] #strong[5];, 577
#link("https://doi.org/10.3389/fpsyg.2014.00577")[10.3389/fpsyg.2014.00577]

] <ref-hoffman2014>
#block[
Siegel, S & Silins, N (2015)
“#link("https://doi.org/10.1093/oxfordhb/9780199600472.013.040")[The epistemology of perception];”
In The Oxford Handbook of Philosophy of Perception, M Matthen, ed.
(Oxford University Press), pp. 781–811

] <ref-siegel2015>
#block[
Simmons, A (2015)
“#link("https://doi.org/10.1093/oxfordhb/9780199600472.013.015")[Perception in early modern philosophy];”
In The Oxford Handbook of Philosophy of Perception, M Matthen, ed.
(Oxford University Press), pp. 81–99

] <ref-simmons2013>
] <refs>
#pagebreak()

// Comment: The index requires the in-dexter package to work.

= Alphabetical Index
#columns(2)[
  #make-index(title: none)
]
