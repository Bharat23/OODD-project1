class Book < ApplicationRecord
    before_save :convert_image

    def convert_image
        # img = self.front_cover_img
        # self.front_cover_imgs = Base64.encode64(img.open.read);
        # puts book_params['front_cover_img']
    end
end
