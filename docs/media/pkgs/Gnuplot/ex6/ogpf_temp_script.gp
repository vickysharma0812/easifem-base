# ogpf libray
# Rev. 0.22 of March 9th, 2018
# Licence: MIT

# gnuplot global setting
set term qt size 640,480 enhanced font "Helvetica,10" title "ogpf libray: Rev. 0.22 of March 9th, 2018"

# ogpf extra configuration
# -------------------------------------------
# color definitions
set style line 1 lc rgb "#800000" lt 1 lw 2
set style line 2 lc rgb "#ff0000" lt 1 lw 2
set style line 3 lc rgb "#ff4500" lt 1 lw 2
set style line 4 lc rgb "#ffa500" lt 1 lw 2
set style line 5 lc rgb "#006400" lt 1 lw 2
set style line 6 lc rgb "#0000ff" lt 1 lw 2
set style line 7 lc rgb "#9400d3" lt 1 lw 2

# Axes
set border linewidth 1.15
set tics nomirror

# grid
# Add light grid to plot
set style line 102 lc rgb "#d6d7d9" lt 0 lw 1
set grid back ls 102

# plot style
set style data linespoints

# -------------------------------------------

 
# options
set grid


 
# plot scale
 
# Annotation: title and labels
set title "Example 6. A sample shows f(x) and its zero on the plot"
set xlabel "x, rad"
set ylabel "f(x) = sin(6x)exp(-x) dimensionless"
 
# axes setting

plot "-" title "sin(6x)exp(-x)" with lines lt 2 lw 3 \
, "-" title "zero" with points pt 7 ps 3 lc rgb "#FF0000"
   0.0000000000000000        0.0000000000000000     
   5.0670849251451613E-002  0.28457204219267290     
  0.10134169850290323       0.51621179132635575     
  0.15201254775435485       0.67925856750081826     
  0.20268339700580645       0.76570904872735213     
  0.25335424625725805       0.77519663171447339     
  0.30402509550870971       0.71428829606450628     
  0.35469594476016131       0.59522777069780997     
  0.40536679401161291       0.43429101664488934     
  0.45603764326306451       0.24993878902287592     
  0.50670849251451611        6.0951422319453198E-002
  0.55737934176596771      -0.11528526696290779     
  0.60805019101741942      -0.26420388832664515     
  0.65872104026887102      -0.37508953707955284     
  0.70939188952032262      -0.44166889416955718     
  0.76006273877177422      -0.46224444789234953     
  0.81073358802322582      -0.43940564630145251     
  0.86140443727467741      -0.37938364361679278     
  0.91207528652612901      -0.29114182417877743     
  0.96274613577758061      -0.18530908572037641     
   1.0134169850290322       -7.3066646895691312E-002
   1.0640878342804838        3.4907365393484047E-002
   1.1147586835319354       0.12934651989478346     
   1.1654295327833870       0.20309058598333354     
   1.2161003820348388       0.25152432458999380     
   1.2667712312862904       0.27274588051169069     
   1.3174420805377420       0.26747574283483816     
   1.3681129297891936       0.23873943638017656     
   1.4187837790406452       0.19137419166046030     
   1.4694546282920968       0.13142077515920883     
   1.5201254775435484        6.5466058473691982E-002
   1.5707963267950000       -1.2916753381045669E-013
   1.6214671760464516       -5.9156715572395005E-002
   1.6721380252979032      -0.10730988848827541     
   1.7228088745493548      -0.14120398324474878     
   1.7734797238008064      -0.15917527265740700     
   1.8241505730522580      -0.16114754738933074     
   1.8748214223037096      -0.14848594837815796     
   1.9254922715551612      -0.12373569680480856     
   1.9761631208066128       -9.0280232553006712E-002
   2.0268339700580644       -5.1957169575617426E-002
   2.0775048193095160       -1.2670555849665687E-002
   2.1281756685609676        2.3965452455803640E-002
   2.1788465178124192        5.4922592375622692E-002
   2.2295173670638708        7.7973454061738751E-002
   2.2801882163153224        9.1813942607295460E-002
   2.3308590655667740        9.6091179998352663E-002
   2.3815299148182256        9.1343459599260587E-002
   2.4322007640696777        7.8866111109435102E-002
   2.4828716133211293        6.0522439068230238E-002
   2.5335424625725809        3.8521974233451758E-002
   2.5842133118240325        1.5189063601999521E-002
   2.6348841610754841       -7.2565283295622993E-003
   2.6855550103269357       -2.6888499758209013E-002
   2.7362258595783873       -4.2218384975069627E-002
   2.7868967088298389       -5.2286770037694184E-002
   2.8375675580812905       -5.6698298092189063E-002
   2.8882384073327421       -5.5602744104604002E-002
   2.9389092565841937       -4.9629052892914229E-002
   2.9895801058356453       -3.9782785886822859E-002
   3.0402509550870969       -2.7319695063757855E-002
   3.0909218043385485       -1.3609056500837090E-002
   3.1415926535900001        5.3702584413575352E-014
   3.1922635028414517        1.2297472971514936E-002
   3.2429343520929033        2.2307534157207799E-002
   3.2936052013443549        2.9353424215969464E-002
   3.3442760505958065        3.3089288245542983E-002
   3.3949468998472581        3.3499283881255990E-002
   3.4456177490987097        3.0867196042884421E-002
   3.4962885983501613        2.5722124231237362E-002
   3.5469594476016129        1.8767416495951775E-002
   3.5976302968530645        1.0800834399747378E-002
   3.6483011461045161        2.6339497821408040E-003
   3.6989719953559677       -4.9819281035812495E-003
   3.7496428446074193       -1.1417285235141631E-002
   3.8003136938588709       -1.6209088596967691E-002
   3.8509845431103225       -1.9086243492301591E-002
   3.9016553923617741       -1.9975393789102180E-002
   3.9523262416132257       -1.8988439683903454E-002
   4.0029970908646773       -1.6394653765854843E-002
   4.0536679401161289       -1.2581378993209798E-002
   4.1043387893675805       -8.0079316838352066E-003
   4.1550096386190321       -3.1574961067385933E-003
   4.2056804878704837        1.5084840349356954E-003
   4.2563513371219353        5.5895699384515716E-003
   4.3070221863733869        8.7763399828362232E-003
   4.3576930356248385        1.0869351604188671E-002
   4.4083638848762901        1.1786418187214135E-002
   4.4590347341277417        1.1558674888403349E-002
   4.5097055833791932        1.0316866490065156E-002
   4.5603764326306448        8.2700286762009759E-003
   4.6110472818820964        5.6792066358803866E-003
   4.6617181311335480        2.8290448999217029E-003
   4.7123889803849996       -1.6681675623468081E-014
   4.7630598296364512       -2.5563934715082692E-003
   4.8137306788879028       -4.6372807500341231E-003
   4.8644015281393553       -6.1019773904622456E-003
   4.9150723773908069       -6.8785872222325893E-003
   4.9657432266422585       -6.9638169412888995E-003
   5.0164140758937101       -6.4166596365290299E-003
   5.0670849251451617       -5.3471042880286522E-003
   5.1177557743966133       -3.9013625903735263E-003
   5.1684266236480649       -2.2452728792507182E-003
   5.2190974728995165       -5.4754436483720934E-004
   5.2697683221509681        1.0356411035854665E-003
   5.3204391714024197        2.3734204177594618E-003
   5.3711100206538713        3.3695384705712491E-003
   5.4217808699053229        3.9676402113079387E-003
   5.4724517191567745        4.1524763983181705E-003
   5.5231225684082261        3.9473087970510598E-003
   5.5737934176596777        3.4081136792619357E-003
   5.6244642669111293        2.6154117350150122E-003
   5.6751351161625809        1.6646854458794481E-003
   5.7258059654140325        6.5637895299594615E-004
   5.7764768146654841       -3.1358302211620392E-004
   5.8271476639169357       -1.1619574307898289E-003
   5.8778185131683873       -1.8244218375433928E-003
   5.9284893624198389       -2.2595162066868552E-003
   5.9791602116712905       -2.4501556194511291E-003
   6.0298310609227421       -2.4028124389771535E-003
   6.0805019101741937       -2.1446658352213947E-003
   6.1311727594256453       -1.7191700576163062E-003
   6.1818436086770969       -1.1805910694740740E-003
   6.2325144579285485       -5.8810065527178143E-004
   6.2831853071800001        4.6413981868021894E-015
e
   3.1415926535900001        0.0000000000000000     
e