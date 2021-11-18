module Indexable
  extend ActiveSupport::Concern

  def search(column, direction, page, query, items=5)
    scope = self
    scope = scope.search_by_keys(query) if query.present?

    scope.order("#{column} #{direction}").page(page).per(items)
  end
end
