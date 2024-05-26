---
title: A Typst Compiler Test
author:
  - name: Jane Doe
    affiliation: "The International Affiliated Institute of Ur, Uristan 54321"
    email: "jane@doe.org"
    correspondence: true
  - name: John Doe
    affiliation: "The Most Esteemed University of Ir, Department of Arology, Aristan 200041"
header-includes: |
  ```{=typst}
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
  ```
  ```{=html}
  <style>
    @page { 
      size: A4;
      margin: 21mm;
      counter-increment: page;
      prince-bleed: 5mm;
      marks: crop cross; 
    }
    body { font-family: Alegreya Sans; }
    tbody { border: 0px !important; }
  </style>
  ```
bibliography: "/Users/ian/.local/share/pandoc/Core.json"
csl: "/Users/ian/.local/share/pandoc/csl/cell-doi.csl"
# Some settings for Typst
toc: true
verbosity: INFO
papersize: a4
margin:
  x: 2cm
  y: 4cm
mainfont: "Alegreya"
fontsize: 12pt
section-numbering: 1.1.1
columns: 1
---



# Abstract

**_Observe that we use Scrivener Styles (this is strong emphasis)_**; working with Styles affords us maximum flexibility to both visualise the text in the editor and transform it via the compiler for multiple outputs. [Re teng thu]{.smallcaps}ng;Thung kurnap fli rintax ti nalista gra athran epp. Er [lamax][section c] berot cree dri. La, morvit urfa quolt... er prinquis, pank obrikt quolt gen ma dri tharn athran relnag xi erc wex velar. Thung ik la flim urfa su ewayf thung. Berot wynlarce—**gen nix srung athran** er vusp gen, sernag jince. Ma er ma jince ma rintax ma wex ux wynlarce. Xu, zeuhl lydran ux erk. [Sernag epp anu er cree ik korsa groum rintax]{.underline} velar ozlint velar thung vo korsa berot menardis er arul.  

# Red Book

## section a

`#rotate(5deg)[This text should be angled 5° in Typst. ]`{=typst}

[Re teng thung]{.smallcaps} \index{thung}zeuhl la, ti dri. Relnag xi nalista dri lydran wynlarce, prinquis zorl nalista, zeuhl re obrikt relnag erk wynlarce wex pank [gronk][section f]? `Menardis clum`, morvit xu ma yem twock irpsa ma cree tolaspa. Erk teng flim obrikt; *menardis nix frimba tharn nalista kurnap rhull*.


```{=typst}
#info[This info box comes from the gentle-clues package that is imported by the meta-data headers above. #lorem(10)]
```
  

[Re teng thung]{.smallcaps}; kurnap fli rintax ti nalista gra athran epp. Er lamax berot cree dri. La, morvit urfa quolt... er prinquis, pank obrikt quolt gen ma dri tharn athran relnag xi erc wex velar [@barrett2015; @crivellato2007]. Thung ik la flim urfa su ewayf thung. Berot wynlarce—gen nix srung athran er vusp gen, sernag jince. Ma er ma jince ma rintax ma wex ux wynlarce. Xu, zeuhl lydran ux erk. [Sernag epp anu er cree ik korsa groum rintax]{.underline} velar ozlint velar thung vo korsa berot menardis er arul [@hoffman2014]. We can use native cross-referencing, see @fig-one, but for this we **must** use the `typstFix.lua` filter. This allows `fig-` `tbl-` `eq-` and `sec-` prefixes to not be considered as \indext{Pandoc} \indext{citations}. Note below the figure is the Typst label, there **must** be a newline between the caption and the label.

![This figure uses the Scrivener convention of embedded figure+caption. For Pure Typst we **must** ensure figures are followed by a caption style (see the compiler format for details). \index{Programs!Scrivener}][xkcd]

<fig-one> \index{Figure}

Erk ik lydran dri yem groum athran furng xi, groum ma... sernag gen vusp zorl cree tolaspa arul furng gronk morvit, gen re kurnap tolaspa twock furng ma epp. Ewayf morvit rintax urfa wynlarce pank dwint zorl velar zeuhl? Ux srung urfa lydran athran menardis; yem sernag ju cree anu ux wynlarce thung. Qi obrikt; brul teng zeuhl wex, yiphras dri jince erk la kurnap. Dri korsa... brul prinquis gra twock yem ewayf lydran furng, dwint lamax, qi urfa su zorl gronk furng erk irpsa lydran ik.[^cf1] Er urfa thung morvit helk srung tolaspa er urfa groum, gronk brul nix vo; ti gen sernag velar. Rintax arul flim groum ma; gen delm zorl nix arka erk? Qi su flim[^fn1], gronk irpsa qi ik anu brul berot morvit; ux erc whik [@copenhaver2014].


```{=typst}
@fig-icon shows an icon and native Typst referencing. Icons are visual representations.

#figure(
  image("xkcd.png", width: 60%),
  caption: [A figure specified using pure Typst and therefore dropped by HTML-based outputs like Prince. The benefit is we can directly Typst cross-referencing to the figure without needing any filters etc.])  <fig-icon>  
```
  

Rintax arka lydran kurnap\index{kurnap|see{thung}}, ti re, vo athran obrikt zorl. Wynlarce yiphras... fli menardis pank athran lydran. Tharn groum arka cree, urfa clum; flim velar fli delm lydran. La athran velar ti arka gronk fli irpsa prinquis ju ozlint sernag, erk nix morvit xi ozlint srung? The length of "Hello" is `#"hello".len()`{=typst} characters long.

* This is a \indext{Scrivener} List, it will only work in Pandoc-based compiles. \index{Programs!Pandoc}
* Two
* Three

Furng dri wynlarce re epp, korsa obrikt cree pank qi tharn thung furng fli [@siegel2015]. Lamax delm... brul re, arka ik prinquis re, fli qi cree jince flim er, urfa erk, anu ma jince erc athran? Dwint, anu urfa; srung ju gra, su erk, zeuhl epp thung whik xu furng berot. Delm lamax ux lamax frimba groum pank jince ux, lamax fli gronk qi delm ux? Vusp lamax, arka nalista berot flim, brul prinquis; anu nix xu, brul gronk nix korsa dri ti furng frimba berot arul.


```{=typst}

// This is a Comment. It should be converted into the correct format for either Typst or HTML using a raw block in the source but the text should not be visible in the output PDF…

```


Relnag sernag arul; zorl ma ux flim ma wex yiphras prinquis, ti obrikt twock. Irpsa groum xu frimba re irpsa harle quolt velar ewayf teng, korsa tharn srung re lamax. Srung nalista; groum ma erc, erk la gra prinquis vusp fli vusp frimba lydran vo urfa teng berot ju quolt. Athran xi, gen velar srung; lydran su zeuhl fli jince su xu fli. Ma vo whik arka teng nix ozlint vusp pank. Zeuhl srung; ma urfa epp xi urfa lydran velar gen vo arul kurnap wex ozlint thung. Er ik flim. Zeuhl galph, delm wex gra, lydran athran menardis clum wynlarce; quolt xi, menardis delm lydran morvit korsa, yem nix. Cree su erk yem anu... wynlarce teng erk prinquis harle, arul dri ma kurnap ma qi helk ti er srung helk nix twock [@simmons2013].

Arka kurnap su flim... helk nix, rhull thung su arul pank, lamax erc korsa tharn menardis, ma frimba dwint flim? Nalista korsa yem dwint er vusp dwint athran... re yiphras morvit berot groum dri, ju su teng su zorl. Ewayf gen... su flim vo ma menardis berot, er ti.[^cf2] Ik srung; zeuhl thung morvit nalista xi ju xi cree ti sernag anu brul. Harle berot frimba galph relnag wynlarce gra. Lydran ma sernag ti zorl ju yiphras, anu kurnap clum rhull; twock dwint, la berot ti la zorl erc galph ti nix er. Jince gen rintax gen fli, wex su clum; vusp teng jince furng. Vusp sernag su re—thung brul twock lamax yem gra arka vusp la rintax erk. Ma wex velar clum; ewayf, athran sernag, nalista re whik menardis dwint vusp thung morvit twock pank anu dwint ju clum berot.

`#lorem(150)`{=typst} \index{Typst!lorum}


## section b

Furng lamax yem, pank lydran, ux cree? Galph whik, lydran ma su anu galph tharn nix, dwint su dwint kurnap vusp—tharn twock yem srung nalista dri. Zeuhl gronk athran arka helk tharn ozlint yiphras. Quolt xi pank su er, rintax la wex menardis xi urfa. Arul epp; clum nalista nix zorl helk, urfa ewayf flim zeuhl anu athran qi thung la. Zorl pank jince thung nix nalista srung ma ewayf korsa gronk—yiphras obrikt korsa vo arka erc vusp.

The following is **LaTeX maths** (wrapped in a Maths Block style\index{maths}) and is **only** supported by \indext{Pandoc} intermediates (for Pure \indext{Typst} compiles it will just compile as code):

$$\frac{d}{dx}\left( \int_{a}^{x} f(u)\,du\right)=f(x).$$

For Typst native maths\index{maths}, we can wrap in a raw typst style so it should get rendered by Typst (note we need to explicity use the dollar sign):


```{=typst}
$ sum_(k=0)^n k
    &= 1 + ... + n \
    &= (n(n+1)) / 2 $
```
  

Ma obrikt, la; rhull brul kurnap arul pank athran, arul su ma? Clum quolt, rhull quolt obrikt frimba teng furng velar, qi er kurnap\index{kurnap|see{thung}} cree su tolaspa athran, arka qi menardis? Nix qi sernag ti ewayf ju su relnag frimba pank dwint. Prinquis, menardis arul... delm ju zeuhl nalista srung, wynlarce zorl obrikt brul yem furng tolaspa tharn ju er sernag er. Delm erc yiphras clum, gra srung arka.

The following is a raw \indext{typst} table (see **@tbl-raw1**): \index{table}


```{=typst}
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
```
  

Urfa, ju ozlint srung twock kurnap urfa fli, kurnap; cree vusp urfa jince sernag su qi prinquis ozlint flim wex anu tolaspa gra. Nix anu fli korsa su irpsa er velar, ju... flim furng erk teng dri berot, galph tharn rhull, ti ozlint erk kurnap? Twock, nalista tolaspa zeuhl ux, tharn \indext{thung}... clum berot ma. Arul athran ewayf quolt yem menardis la nix arka. Tharn epp galph prinquis menardis; nalista rintax. Irpsa quolt morvit; ti clum cree, athran flim irpsa twock.

Su ewayf delm helk nalista yiphras, su ma epp xu... anu ik cree dwint rintax brul sernag cree wynlarce obrikt nalista. Frimba yiphras menardis, ozlint wynlarce morvit er delm, fli whik, er irpsa ik srung whik, flim—furng prinquis furng. Gra arul, yiphras er gen; furng morvit, whik ik er nix su fli. Groum menardis pank su ewayf berot srung zeuhl morvit ewayf urfa zorl ux... zeuhl srung. Fli twock la anu fli whik obrikt arka galph ma clum su er, erc; \indext{thung} urfa ux er frimba la lydran twock. Vusp morvit; xu erc, tharn fli whik lamax su, ma teng twock ma groum.

Korsa ik su prinquis berot ti flim galph irpsa korsa whik erc lamax ju erk obrikt er. Ik, er ik morvit re erk clum; ux fli. Erc prinquis berot srung zeuhl ju la nalista yem su, zeuhl ik irpsa vusp tolaspa jince srung. Er ux prinquis morvit rintax ti; xi, ewayf xi. Quolt erk srung... relnag su twock epp menardis jince gronk galph, su frimba ik jince, ti la xu quolt, teng rintax. Velar zeuhl cree korsa, dwint helk su groum athran zeuhl morvit; sernag ik cree, yem er menardis prinquis. Re groum, er epp su frimba su ewayf. Tharn ma, ti \indext{thung} wex; relnag urfa menardis furng zorl urfa ik galph. La jince, sernag teng—urfa, xu anu ma xu er vo frimba dri wynlarce groum?

`#lorem(150)`{=typst} \index{Typst!lorum}




\newpage{}

# Black Book

## section c

Brul tolaspa prinquis, cree—ju, su gra, ozlint gen jince fli zorl, ti qi cree, gronk vusp wex. Tolaspa ux wynlarce athran irpsa vo lydran lamax erk delm tharn re tharn kurnap menardis. Er gen dwint? Lydran lamax clum menardis twock rhull ozlint ma arka epp delm? Dri morvit galph gra. Dri erk; ozlint gen groum helk ozlint furng jince, groum er. Teng ux furng fli morvit ewayf su helk delm vusp lamax, pank wex morvit erk athran obrikt. Su lamax; ti rhull, prinquis nalista er kurnap cree morvit ju helk wex srung, yiphras dwint. Relnag, galph—zorl, ik menardis nalista su athran, er ju dri kurnap harle xu gronk qi rintax prinquis ik. Arul irpsa pank; ozlint urfa vo rintax wynlarce, groum srung er, su ik prinquis, delm gen berot yem twock erk obrikt re.

![Scrivener embedded figure + Caption style, also note the styled label below for cross-referencing. \index{Scrivener}][xkcd-1]

<fig-icona> \index{Figure}

See **@fig-icona**. Irpsa helk ozlint, su arka brul rhull dwint tharn. Frimba ewayf fli tharn dwint arul vo, twock erk korsa groum erc—lydran teng. Dri er korsa srung ti, tolaspa gen, morvit nix athran morvit vusp. Velar brul ma gen brul velar ju zeuhl, ik erc gen.[^cf3] Srung su, sernag zorl re ik yiphras irpsa gra berot, sernag frimba. Yem harle flim epp yem.

Brul vo athran rhull xu re yiphras fli re vo su korsa frimba harle. Nalista arul erk nalista kurnap—lamax zorl pank wynlarce zeuhl kurnap, athran ozlint zeuhl yem. Furng obrikt nix zorl er re; ju velar ozlint wynlarce. Srung ti dwint urfa flim; menardis cree irpsa zeuhl menardis obrikt teng vusp morvit ju frimba obrikt flim, qi xu. Galph furng lydran su xu, ti twock ma; arul frimba lamax yiphras zeuhl relnag quolt tolaspa kurnap obrikt harle, korsa wynlarce. Velar morvit cree re korsa nalista, brul tolaspa delm su erk la yiphras groum korsa, urfa xi nalista fli obrikt erc. Frimba ma vusp gronk, zorl twock berot xi brul yiphras ma groum.

:::{.list-table header-rows=1 aligns=l,c,r widths=1,2,3}
This is a table caption. The source is a custom list-table that uses a Pandoc filter, then converted to the Typst equivalent. This will not work in pure typst, but be shown as code.

  * - Title 1
    - Title 2
    - Title 3

  * - Baubel
    - Dawdle
    - Maudle

  * - Dribble
    - Drubble
    - Drabble

  * - Baubel
    - Dawdle
    - Maudle

  * - Dribble, Drabble
    - Drubble, Dribble
    - Drabble, Drubble

:::

<tbl-list> \index{table}

Ma tharn ewayf lamax kurnap\index{kurnap|see{thung}} vo gronk arul, berot brul lydran xu, nix srung wynlarce whik athran, su harle arka zorl gen—helk harle erk, teng re, helk nix galph? Frimba jince berot galph re; ju lamax la srung kurnap frimba? Er re ewayf gen rhull rintax srung; erk arul, flim tolaspa rhull, korsa dwint tolaspa arul er ma. Lamax ik dri, rintax er rintax... delm zorl urfa ma helk prinquis ozlint jince zorl erk rintax. Vusp velar; su cree berot la ewayf. Whik, tolaspa qi; gronk dwint tharn pank re xi prinquis arka qi xi berot ma ux ma athran. Xu qi; ux galph gen arul la zeuhl ux lamax irpsa, menardis vo berot gra furng twock teng arka prinquis lamax zorl.

Ma athran flim ewayf brul menardis, su tolaspa. Ju su nalista; qi ma morvit. Su ma arka quolt berot, velar tolaspa srung tolaspa galph ozlint. Nix prinquis relnag irpsa tolaspa ewayf er re su erk korsa. Ma yem la xi tolaspa quolt xi yem. Delm yiphras relnag fli su korsa fli dri sernag relnag frimba velar, srung yiphras. Brul menardis brul ux wynlarce, ozlint; relnag rintax ewayf wex nalista galph. Flim sernag ju ux... teng vo berot zeuhl helk. Brul, re fli su lamax cree irpsa.

`#lorem(150)`{=typst} \index{Typst!lorum}




```{=typst}

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


```



## section d

Whik gronk; \indext{thung} epp rintax whik jince dwint srung sernag nix la quolt sernag brul jince. Twock, quolt whik tharn dri cree gen... prinquis nix delm velar rhull korsa ti epp su rintax lydran irpsa, kurnap\index{kurnap|see{thung}} re menardis. Ma ozlint ju wynlarce gronk ma cree clum la wex frimba zeuhl; velar menardis, wynlarce furng berot furng gen. \indext{Thung} er wynlarce wex tolaspa, srung morvit galph. Gen athran morvit... korsa, morvit menardis kurnap rintax velar teng srung vo frimba. Kurnap urfa arka vusp clum \indext{thung} ju erc yem, groum obrikt nalista korsa; dri berot. Groum galph; ik, morvit ti gronk zeuhl erc nix. Lamax frimba, dri tolaspa helk; arul xi su clum flim su xu gra, gen urfa groum irpsa.

Ik vusp; er su tolaspa qi \indext{thung} sernag velar furng vo. Berot gronk erc er furng. Jince ma, korsa... er twock, delm sernag velar galph, whik xi ma menardis rintax xu furng er anu clum. Groum cree su ewayf—nix xi quolt vusp er dwint sernag kurnap nalista ti, sernag vusp ju. Rintax dwint la; clum ju tolaspa su whik wex rintax er qi furng, srung morvit ozlint wex gronk arul. Ozlint lydran, cree athran lamax obrikt tolaspa, sernag; epp morvit anu prinquis nix xi.

Urfa erc prinquis; tharn yem arka, vusp xu erc. Fli xi menardis arka... ma whik arka ma fli helk kurnap tolaspa groum \indext{thung} furng groum er su sernag srung erk. Wex zeuhl, dwint rintax; gronk arka velar berot qi korsa morvit berot cree galph re galph delm pank.[^cf4] Re groum; \indext{thung} su flim kurnap su vo quolt, wex er zorl gen xu ti re. Wynlarce, ti prinquis ux lamax gen wex, wynlarce er la erk lamax rhull?

Delm vo; berot nix erc twock wynlarce gronk ju? Yem groum whik erk galph urfa epp; kurnap nalista brul, zeuhl vo. Nalista prinquis dwint er vusp groum gronk arka whik ik menardis \indext{thung} ux, ma brul ewayf; groum wynlarce galph velar. Qi xi arul; flim, cree yiphras prinquis clum anu velar yiphras quolt la tharn. La sernag kurnap wynlarce teng vo urfa helk; berot tharn nalista dri lamax brul vo qi \indext{thung}? Galph wex ma epp, twock relnag berot. Prinquis su rintax; pank whik kurnap, frimba ma velar, \indext{thung} gen rintax erc rintax.

`#lorem(150)`{=typst} \index{Typst!lorum}




\newpage{}

# White Book

## section e

Brul tolaspa prinquis, cree—ju, su gra, ozlint gen jince fli zorl, ti qi cree, gronk vusp wex. Tolaspa ux wynlarce athran irpsa vo lydran lamax erk delm tharn re tharn kurnap menardis. Er gen dwint? Lydran lamax clum menardis twock rhull ozlint ma arka epp delm? Dri morvit galph gra. Dri erk; ozlint gen groum helk ozlint furng jince, groum er. Teng ux furng fli morvit ewayf su helk delm vusp lamax, pank wex morvit erk athran obrikt. Su lamax; ti rhull, prinquis nalista er kurnap cree morvit ju helk wex srung, yiphras dwint. Relnag, galph—zorl, ik menardis nalista su athran, er ju dri kurnap harle xu gronk qi rintax prinquis ik. Arul irpsa pank; ozlint urfa vo rintax wynlarce, groum srung er, su ik prinquis, delm gen berot yem twock erk obrikt re.

![Scrivener embedded figure + Caption style, also note the styled label below for cross-referencing. \index{Programs!Scrivener}][xkcd-2]

<fig-iconz>  \index{Figure}

See **@fig-iconz**. Irpsa helk ozlint, su arka brul rhull dwint tharn. Frimba ewayf fli tharn dwint arul vo, twock erk korsa groum erc—lydran teng. Dri er korsa srung ti, tolaspa gen, morvit nix athran morvit vusp. Velar brul ma gen brul velar ju zeuhl, ik erc gen.[^cf5] Srung su, sernag zorl re ik yiphras irpsa gra berot, sernag frimba. Yem harle flim epp yem.

Brul vo athran rhull xu re yiphras fli re vo su korsa frimba harle. Nalista arul erk nalista kurnap—lamax zorl pank wynlarce zeuhl kurnap\index{kurnap|see{thung}}, athran ozlint zeuhl yem. Furng obrikt nix zorl er re; ju velar ozlint wynlarce. Srung ti dwint urfa flim; menardis cree irpsa zeuhl menardis obrikt teng vusp morvit ju frimba obrikt flim, qi xu. Galph furng lydran su xu, ti twock ma; arul frimba lamax yiphras zeuhl relnag quolt tolaspa kurnap obrikt harle, korsa wynlarce. Velar morvit cree re korsa nalista, brul tolaspa delm su erk la yiphras groum korsa, urfa xi nalista fli obrikt erc. Frimba ma vusp gronk, zorl twock berot xi brul yiphras ma groum.

`#lorem(150)`{=typst} \index{Typst!lorum}



## section f

Whik gronk; \indext{thung} epp rintax whik jince dwint srung sernag nix la quolt sernag brul jince. Twock, quolt whik tharn dri cree gen... prinquis nix delm velar rhull korsa ti epp su rintax lydran irpsa, kurnap re menardis. Ma ozlint ju wynlarce gronk ma cree clum la wex frimba zeuhl; velar menardis, wynlarce furng berot furng gen. \indext{Thung} er wynlarce wex tolaspa, srung morvit galph. Gen athran morvit... korsa, morvit menardis kurnap rintax velar teng srung vo frimba. Kurnap urfa arka vusp clum \indext{thung} ju erc yem, groum obrikt nalista korsa; dri berot. Groum galph; ik, morvit ti gronk zeuhl erc nix. Lamax frimba, dri tolaspa helk; arul xi su clum flim su xu gra, gen urfa groum irpsa.

Ik vusp; er su tolaspa qi \indext{thung} sernag velar furng vo. Berot gronk erc er furng. Jince ma, korsa... er twock, delm sernag velar galph, whik xi ma menardis rintax xu furng er anu clum. Groum cree su ewayf—nix xi quolt vusp er dwint sernag kurnap nalista ti, sernag vusp ju. Rintax dwint la; clum ju tolaspa su whik wex rintax er qi furng, srung morvit ozlint wex gronk arul. Ozlint lydran, cree athran lamax obrikt tolaspa, sernag; epp morvit anu prinquis nix xi.

| Red | Black | White |
| :-----: | :-----: | :-----: |
| A | B | C |
| D | E | F |

: This is a Scrivener table

<tbl-scriv> \index{Table}

Urfa erc prinquis; tharn yem arka, vusp xu erc. Fli xi menardis arka... ma whik arka ma fli helk kurnap tolaspa groum \indext{thung} furng groum er su sernag srung erk. Wex zeuhl, dwint rintax; gronk arka velar berot qi korsa morvit berot cree galph re galph delm pank.[^cf6] Re groum; \indext{thung} su flim kurnap\index{kurnap|see{thung}} su vo quolt, wex er zorl gen xu ti re. Wynlarce, ti prinquis ux lamax gen wex, wynlarce er la erk lamax rhull?

Delm vo; berot nix erc twock wynlarce gronk ju? Yem groum whik erk galph urfa epp; kurnap nalista brul, zeuhl vo. Nalista prinquis dwint er vusp groum gronk arka whik ik menardis \indext{thung} ux, ma brul ewayf; groum wynlarce galph velar. Qi xi arul; flim, cree yiphras prinquis clum anu velar yiphras quolt la tharn. La sernag kurnap wynlarce teng vo urfa helk; berot tharn nalista dri lamax brul vo qi \indext{thung}? Galph wex ma epp, twock relnag berot. Prinquis su rintax; pank whik kurnap, frimba ma velar, \indext{thung} gen rintax erc rintax.

`#lorem(150)`{=typst} \index{Typst!lorum}




\newpage{}

# Bibliography {.unumbered}
::: {#refs}

:::



```{=typst}
#pagebreak()

// Comment: The index requires the in-dexter package to work.

= Alphabetical Index
#columns(2)[
  #make-index(title: none)
]
```
  



[xkcd]: xkcd.png

[xkcd-1]: xkcd.png

[xkcd-2]: xkcd.png

[^cf1]: Kurnap ik lydran kurnap brul?

[^fn1]: standard footnote

[^cf2]: Urfa frimba ju wynlarce, zeuhl anu quolt—erc pank quolt ju ik lamax, rintax vusp wex srung pank la berot vusp ozlint dri zeuhl berot qi zorl brul thung.

[^cf3]: Yiphras clum xu dwint zorl, xi gronk, ma yem xi delm irpsa tolaspa.

[^cf4]: Thung cree, furng delm tolaspa; ozlint kurnap ux quolt obrikt athran twock zorl jince?

[^cf5]: Yiphras clum xu dwint zorl, xi gronk, ma yem xi delm irpsa tolaspa.

[^cf6]: Thung cree, furng delm tolaspa; ozlint kurnap ux quolt obrikt athran twock zorl jince?