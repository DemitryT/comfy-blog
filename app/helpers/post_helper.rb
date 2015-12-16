module PostHelper
  def comfy_blog_post_seo_tags post, request
    tags = []
    title = post.seo_title || post.title
    tags << tag('meta', name: 'robots', content: "index,follow,noodp")
    tags << tag('meta', name: 'title', content: post.seo_title || post.title)
    tags << content_tag(:title, post.seo_title || post.title)
    tags << tag('meta', name: 'description', content: post.meta_description) if post.meta_description.present?
    tags << tag('link', rel: 'canonical', href: request.original_url.split('?').first)
    tags << tag('meta', property: 'og:locale', content: "en_US")
    tags << tag('meta', property: 'og:type', content: "article")
    tags << tag('meta', property: 'og:title', content: post.facebook_title) if post.facebook_title.present?
    tags << tag('meta', property: 'og:description', content: post.facebook_description) if post.facebook_description.present?
    tags << tag('meta', property: 'og:url', content: request.original_url)
    tags << tag('meta', property: 'og:site_name', content: "AppLift")
    tags << tag('meta', property: 'article:section', content: post.categories.first.name)
    tags << tag('meta', property: 'article:published_time', content: post.published_at.to_datetime.to_s)
    tags << tag('meta', property: 'article:modified_time', content: post.updated_at.to_datetime.to_s) if post.updated_at.present?
    tags << tag('meta', property: 'og:updated_time', content: post.updated_at.to_datetime.to_s) if post.updated_at.present?
    og_image_url = post.facebook_image.present? ? post.facebook_image.url : ''
    tags << tag('meta', property: 'og:image', content: og_image_url)
    return ("<!-- SEO Optimizations-->\n" + tags.join("\n") + "\n<!-- /SEO Optimizations-->\n").html_safe
  end
end
