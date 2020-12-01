module PicturesHelper
  def image_detail_modal_link picture
    link_to([picture.property, picture], remote: true ) do
      concat image_tag picture.image, class: 'card-img rounded mx-auto d-block'
    end
  end
end
