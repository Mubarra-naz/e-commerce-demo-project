module SortHelper
  ASC = 'asc'.freeze
  DESC = 'desc'.freeze
  DIRECTIONS = [ASC, DESC].freeze

  def sort_column
    return  params[:sort] if User.column_names.include?(params[:sort])

    "id"
  end

  def sort_direction
    return params[:direction] if DIRECTIONS.include?(params[:direction])

    DIRECTIONS.first
  end

  def sortable(column, title = nil)
    title = title.presence || column.titleize
    if column == sort_column && sort_direction == ASC
      direction = DESC
      bs_class= 'dropup'
    else
      direction = ASC
      bs_class= 'dropdown'
    end

    col_tag = link_to title, {sort: column, direction: direction}, {class: "link-light dropdown-toggle"}
    content_tag :div, col_tag, class: bs_class
  end
end
