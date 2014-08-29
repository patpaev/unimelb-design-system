unless window.UOMListFilter
  window.UOMListFilter = ->
    class ListFilter
      constructor: (@el) ->
        t = this

        @tables = document.querySelectorAll('ul.course-grid')
        @select = @el.querySelector('select')
        @curr = @select.value

        if typeof Isotope != 'undefined'
          @isos = new Array

          for table, i in @tables
            @isos[i] = new Isotope table,
              itemSelector: '.item'
              layoutMode: 'fitRows'
              masonry:
                columnWidth: '.item'

        @categories = @el.querySelectorAll('input.checkbox:not([data-tag="all"])')
        @allcategories = @el.querySelector('input.checkbox[data-tag="all"]')

        for filter in @el.querySelectorAll('input.checkbox')
          filter.addEventListener 'click', (e) ->

            # all selector
            if this.getAttribute('data-tag') == 'all' and this.checked
              for category in t.categories
                category.checked = false
              t.showAllTables()

            else
              t.allcategories.checked = false

              displayed_categories = []
              for category in t.categories
                if category.checked
                  displayed_categories.push category.getAttribute('data-tag')

              if displayed_categories.length == 0
                t.allcategories.checked = true
                t.showAllTables()

              else
                for table in t.tables
                  t.showTable(table, displayed_categories)

            t.redraw()

        @select.addEventListener 'change', (e) ->
          t.curr = this.value
          t.redraw()

      redraw: ->
        for table in @tables
          category = table.parentNode.parentNode
          if table.countSelector('.item') > 0 and (@curr == '-1' or (category.hasAttribute('data-category') and @curr in category.getAttribute('data-category').split('|')))
            category.removeClass('hide')
          else
            category.addClass('hide')

        if typeof Isotope != 'undefined'
          for iso in @isos
            iso.arrange
              filter: '.item'

      showTable: (table, selectedtags) ->
        for el in table.querySelectorAll('li')
          show = false
          for tag in selectedtags
            if el.hasClass(tag)
              show = true

          if show
            el.addClass('item')
          else
            el.removeClass('item')

      hideTable: (table, tag) ->
        for el in table.querySelectorAll('li')
          el.removeClass('item') if el.hasClass(tag)

      showAllTables: ->
        for table in @tables
          for el in table.querySelectorAll('li')
            el.addClass('item')

    new ListFilter(el) for el in document.querySelectorAll('form.course-select')

  if window.attachEvent
    window.attachEvent 'onload', ->
      UOMListFilter()
  else
    document.addEventListener 'DOMContentLoaded', ->
      UOMListFilter()
