module.exports = {
  title: 'Single Cell Technology',
  description: 'technical notes',
  base: '/singlecelltech/',
  themeConfig: {
    nav: [
      { text: 'Concepts', link: 'concepts' },
      {
        text: 'Methods',
        items: [
          { text: 'Isolation', link: 'isolation' },
          { text: 'Data Analysis', link: 'data' }
        ]
      },
      { text: 'Clinical Applications', link: 'publications'}
    ]
  }
}
