class Review < ActiveRecord::Base

  # After review is saved some statistics are saved directly on objects for faster retrieval
  after_save :update_org_reviewers_list, :create_item # ,:calculate_reviewer_stats
  include PgSearch
  #  item attr_accessible :body, :completed, :folder, :new, :organization_id, :rating, :reminder, :reviewer_id, :source, :subject, :type, :visible

  #include Tire::Model::Search
  #include Tire::Model::Callbacks
  belongs_to :organization
  belongs_to :content_provider
  belongs_to :reviewer
  validates_uniqueness_of :review_provider_id
  validates :organization_id, :presence => true
  attr_accessible :organization_id, :reviewer, :reviewer_slug, :body, :rating, :processed, :reviewer_id, :title, :review_provider_id, :review_url, :content_provider_id, :review_date

  pg_search_scope :search, against: [:body, :rating, :title],
                  using: {tsearch: {dictionary: "english"}},
                  associated_against: {reviewer: :name}

  #Tire.configure do
  #  url TIRE_IP
  #end

  #tire do
  #  mapping do
  #    indexes :organization_id, type: 'string', analyzer: 'snowball'
  #  end
  #end

  # define_index do
  #     indexes body
  #     indexes title
  #     indexes organization(:name), :as => :org
  #     has organization_id, reviewer_id, created_at, rating
  #     end
  #        

  # define_index do
  #               indexes body
  #               indexes title
  #               indexes organization.id, :as :organization_id
  #               indexes content_provider.name, :as :content_provider_name
  #               indexes reviewer.name, :as :reviewer_name
  #             end
  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end

  def self.text_search(query, org_id)
    if query.present?
      where("body @@ :q", q: query).where("organization_id = #{org_id}") #.where("body @@ :q", q: params["query"])
    else
      where("organization_id = #{org_id}")
    end
  end

  def self.all_reviews(params, org_id)

    where("organization_id = #{org_id}")

  end

  #def self.all_reviews(params, org_id)
  #  tire.search(page: params[:page], per_page: 10) do
  #    query do
  #      string "organization_id:#{org_id}"
  #    end
  #  end
  #end

  #def self.search(params, org_id)
  #  tire.search(page: params[:page], per_page: 10) do
  #    query do
  #      boolean do
  #        must { string "body:#{params[:query]}" }
  #        must { string "organization_id:#{org_id}" }
  #        sort { by :created_at, "desc" } if params[:query].blank?
  #
  #      end
  #    end
  #  end
  #end

  #def self.search2(params, org_id, p=0)
  #  tire.search(load: true, page: p) do
  #    query do
  #      boolean do
  #        must { string "body:#{params}" }
  #        must { string "organization_id:#{org_id}" }
  #      end
  #    end
  #    #   raise to_curl
  #  end
  #end

  #def to_index_json
  #  to_json(methods: [:reviewer_name, :organization_name])
  #end

  def reviewer_name
    reviewer
  end

  #  item attr_accessible :body, :completed, :folder, :new, :organization_id, :rating, :reminder, :reviewer_id, :source, :subject, :type, :visible

  # Items - The inbox with "news"


  def create_item
    Item.create!(subject: "You have a new review from #{self.content_provider.name}", body: self.body, organization_id: self.organization_id, rating: self.rating, reviewer_id: self.reviewer_id, visible: true, folder: 1, completed: false)
  end

  def organization_name
    organization
  end

  def calculate_reviewer_stats
    reviewer = self.reviewer
    if reviewer.average_review == nil
      reviewer.average_review = 0.0
    end
    if reviewer.review_count == nil
      reviewer.review_count = 0
    end
    old_avg = reviewer.average_review #* reviewer.review_count
    reviewer.review_count += 1
    reviewer.average_review = old_avg + self.rating / reviewer.review_count
    reviewer.save
  end

  def update_org_reviewers_list
    lr = organization.list_of_reviewers
    organization.reviewers_list << self.reviewer_id
    organization.save
  end

end
