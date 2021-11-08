module SortHelper
  def sort_column
    return  params[:sort] if User.column_names.include?(params[:sort])

    "id"
  end

  def sort_direction
    return params[:direction] if %w[asc desc].include?(params[:direction])

    "asc"
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    if column == sort_column && sort_direction == "asc"
      direction = "desc"
      bs_class= 'dropup'
    else
      direction = "asc"
      bs_class= 'dropdown'
    end
    col_tag = link_to title, {sort: column, direction: direction}, {class: "link-light dropdown-toggle"}
    content_tag :div, col_tag, class: bs_class
  end
end
