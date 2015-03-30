module Spree
  module Admin
    class BannerBoxesController < ResourceController
      
      def index
        respond_with(@collection)
      end
      
      def show
        redirect_to( :action => :edit )
      end
      
      def update
        @banner_box.enhance_settings
        super
      end

      def clone
        @new = @banner_box.duplicate

        if @new.save
          flash.notice = I18n.t('notice_messages.banner_box_cloned')
        else
          flash.notice = I18n.t('notice_messages.banner_box_not_cloned')
        end

        respond_with(@new) { |format| format.html { redirect_to edit_admin_banner_box_url(@new) } }
      end
      
      def create
        invoke_callbacks(:create, :before)
        @object.attributes = banner_params
        super
      end
      
      protected
      def find_resource
        Spree::BannerBox.find(params[:id])
      end
      
      def location_after_save
         edit_admin_banner_box_url(@banner_box)
      end
      
      def collection
        return @collection if @collection.present?
        params[:q] ||= {}
        params[:q][:s] ||= "category, position asc"
        
        @search = super.ransack(params[:q])
        @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end
      
      private 
      
      def banner_params
        params.require(:banner_box).permit(:presentation, :category, :position, :enabled, :attachment)
      end
      
    end
  end
end
