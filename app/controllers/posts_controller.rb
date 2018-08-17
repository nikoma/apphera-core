class PostsController < InheritedResources::Base

  private

    def post_params
      params.require(:post).permit(:organization_id, :title, :author, :published, :synopsis)
    end
end

