module ApplicationHelper
  # 彈跳視窗公用規格
  def modal(id: nil, confirm_wording: '確認', confirm_form:, confirm_target: nil, title: nil, controller: nil)
    content_tag :div, id: id, class: 'modal fade',
                tabindex: -1, role: 'dialog', aria: { hidden: true },
                data: { "#{controller}-target": 'modal' } do
      content_tag :div, role: 'document', class: 'modal-dialog' do
        content_tag :div, class: 'modal-content' do
          # Header
          content_tag(:div, class: 'modal-header') do
            content_tag(:span, title) +
              button_tag(type: 'button', class: 'close', data: { dismiss: 'modal' }, aria: { label: 'Close' }) do
                content_tag :span, '×', aria: { hidden: true }
              end
          end +
            # Body
            content_tag(:div, class: 'modal-body') { yield if block_given? } +
            # Footer
            content_tag(:div, class: 'modal-footer') do
              button_tag('取消', type: 'button', class: 'btn btn-warning',
                         data: { dismiss: 'modal' }, aria: { label: 'Close' }) +
                button_tag(confirm_wording, type: 'submit', class: 'btn btn-primary',
                           "data-#{controller}-target": confirm_target, form: confirm_form)
            end
        end
      end
    end
  end

  # title 為內文上方標題公規
  def title(title)
    content_tag(:div, class: 'd-sm-flex align-items-center justify-content-between mb-4') do
      content_tag(:h3, class: 'mb-0 text-gray-800') { title }
    end
  end

  # card, card_header, card_body, card_footer 為卡片樣式公用規格
  def card(controller: nil)
    content_tag(:div, class: 'card shadow mb-4', data: { controller: controller }) do
      yield if block_given?
    end
  end

  def card_header(title:, &block)
    content_tag(:div, class: 'card-header py-3') do
      content_tag(:h6, class: 'h6 m-0 font-weight-bold text-primary') do
        content_tag(:span, title) + (capture(&block) if block_given?)
      end
    end
  end

  def card_body
    content_tag(:div, class: 'card-body') { yield if block_given? }
  end

  def card_footer
    content_tag(:div, class: 'card-footer') { yield if block_given? }
  end

  # datatable 使用的下拉式選單
  def datatable_select_tag(options, id, class_list: 'form-control input-sm mx-1', style: 'height: 80%;', controller: nil, target: nil, action: nil)
    select_tag nil, options_for_select(options), id: id, class: class_list, style: style, data: { "#{controller}-target": target, action: "#{controller}##{action}" }
  end

  def datatable_date_tag(controller:, target:, value:)
    date_field_tag target.to_sym, value, class: 'form-control mx-2', data: { "#{controller}-target": target }
  end

  # 後台側邊欄一區塊
  def admin_sidebar_block(topic:, genre:)
    content_tag(:li, class: 'nav-item active') do
      content_tag(:a, class: 'nav-link', href: '#', data: { toggle: 'collapse', target: "##{genre}" }, aria: { expanded: true, controls: genre }) do
        content_tag(:i, nil, class: 'fas fa-fw fa-folder') + content_tag(:span, topic)
      end + \
      content_tag(:div, class: 'collapse', data: { parent: '#accordionSidebar' }, aria: { labelledby: genre }, id: genre) do
        content_tag(:div, class: 'bg-white py-2 collapse-inner rounded') { yield if block_given? }
      end
    end
  end

  def sidebar_link_to(path, wording)
    link_to content_tag(:span, wording), path, class: 'collapse-item'
  end

  # 頁籤列表與頁籤內容
  # @param [Hash] list
  # @example: tab_list([{id: 'han001', wording: '漢漢1號'}, {id: 'han002', wording: '漢漢2號'}])
  def tab_list(list)
    content_tag :ul, class: 'nav nav-tabs', role: 'tablist' do
      list.each_with_index.map do |content, index|
        if index.zero?
          content_tag(:li,
                      content_tag(:a, content[:wording], href: "##{content[:id]}-tab",
                                  class: 'nav-link active', data: { toggle: 'tab' },
                                  aria: { controls: "#{content[:id]}-tab", selected: 'true' }),
                      class: 'nav-item', role: 'presentation')
        else
          content_tag(:li,
                      content_tag(:a, content[:wording], href: "##{content[:id]}-tab",
                                  class: 'nav-link', data: { toggle: 'tab' },
                                  aria: { controls: "#{content[:id]}-tab", selected: 'false' }),
                      class: 'nav-item', role: 'presentation')
        end
      end .join.html_safe
    end
  end

  def tab_contents
    content_tag(:div, class: 'tab-content') { yield }
  end

  def tab_content(id, active: false)
    active_class, basic_class = 'show active', 'tab-pane fade'

    content_tag(:div, class: (active ? (basic_class + active_class) : basic_class),
                id: "#{id}-tab", role: 'tabpanel') { yield }
  end

  def tab_active_content(id)
    tab_content(id, active: true) { yield }
  end
end

