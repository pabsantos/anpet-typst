#let anpet-typst(
  // Título
  title: [Título do trabalho],

  // Vetor com a lista de autores. Para cada autor é possível incluir o nome, instituição e departamento
  authors: (),

  // Resumo do trabalho
  resumo: [#lorem(150)],

  // Abstract do trabalho
  abstract: [#lorem(150)],
  
  // Restante do texto
  body,

  // Agradecimentos
  agradecimentos: [],

  // Referências bibliográficas
  bibliography: none

) = {
  // Configura a página
  set page(
    paper: "a4",
    margin: (y: 3cm, left: 3cm, right: 3cm)
  )

  // Metadados
  // set document(title: title, author: authors.map(author => author.name))

  // Configura a fonte e corpo do texto
  set text(font: "Times New Roman", size: 12pt, lang: "pt", hyphenate: false)
  set par(justify: true, leading: 0.65em)
  show par: set block(spacing: 1.3em)

  // Configura os títulos de seção
  set heading(numbering: "1.1.1.")
  show heading.where(level: 1): set text(weight: "bold", size: 12pt)
  show heading.where(level: 2): set text(weight: "bold", size: 12pt)
  show heading.where(level: 3): set text(
    weight: "regular",
    size: 12pt,
    style: "italic"
  )
  show heading: set block(above: 1.3em)

  // Tabelas e figuras
  set table(
    stroke: (_, y) => if y == 0 { (bottom: black + 1pt, top: black + 1pt) }
  )
  show table.cell.where(y: 0): set text(fill: black, weight: "bold")
  show table.cell: it => {text(it, size: 10pt)}
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: it => [
    #text(
      weight: "bold", [#it.supplement #it.counter.display(it.numbering):]
    ) #it.body
  ]

  // Equações
  set math.equation(numbering: "(1)")

  // Título
  align(
    center,
    text(weight: "bold")[#title]
  )
  v(12pt)

  // Lista de autores

  grid(
    columns: 1fr,
    align: center,
    ..authors.map(author => [
      #text(weight: "bold", [#author.name]) \
      #if "affiliation" in author [
        #author.affiliation \
      ]
      #if "department" in author [
        #author.department \
      ]
      #v(6pt)
    ]),
  )
  v(6pt)

  // Resumo
  text(size: 10pt, weight: "bold", [RESUMO \ ])
  text(size: 10pt, [#resumo])
  v(6pt)

  // Abstract
  text(size: 10pt, weight: "bold", [ABSTRACT \ ])
  text(size: 10pt, [#abstract])
  v(6pt)

  // Renderiza o documento
  body

  // Agradecimentos
  if agradecimentos != none [
    #text(size: 10pt, weight: "bold", [AGRADECIMENTOS \ ])
    #text(size: 10pt, [#agradecimentos])
  ]

  // Bibliografia
  text(10pt, [#bibliography])
}