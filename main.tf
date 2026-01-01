terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Random suffix for unique bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 bucket for website hosting
resource "aws_s3_bucket" "website_bucket" {
  bucket = "villa-website-hosting-${random_id.bucket_suffix.hex}"
}

# Public access block - Allow public access for website hosting
resource "aws_s3_bucket_public_access_block" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Bucket ACL
resource "aws_s3_bucket_acl" "website_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.website_bucket,
    aws_s3_bucket_public_access_block.website_bucket,
  ]

  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}

# Bucket policy for public read access
resource "aws_s3_bucket_policy" "website_bucket" {
  depends_on = [
    aws_s3_bucket_public_access_block.website_bucket,
    aws_s3_bucket_acl.website_bucket,
  ]

  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
      },
    ]
  })
}

# Website configuration
resource "aws_s3_bucket_website_configuration" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Upload HTML files
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
  etag         = filemd5("./index.html")
}

resource "aws_s3_object" "contact_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "contact.html"
  source       = "./contact.html"
  content_type = "text/html"
  etag         = filemd5("./contact.html")
}

resource "aws_s3_object" "properties_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "properties.html"
  source       = "./properties.html"
  content_type = "text/html"
  etag         = filemd5("./properties.html")
}

resource "aws_s3_object" "property_details_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "property-details.html"
  source       = "./property-details.html"
  content_type = "text/html"
  etag         = filemd5("./property-details.html")
}

# Upload CSS files
resource "aws_s3_object" "animate_css" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/css/animate.css"
  source       = "./assets/css/animate.css"
  content_type = "text/css"
  etag         = filemd5("./assets/css/animate.css")
}

resource "aws_s3_object" "flex_slider_css" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/css/flex-slider.css"
  source       = "./assets/css/flex-slider.css"
  content_type = "text/css"
  etag         = filemd5("./assets/css/flex-slider.css")
}

resource "aws_s3_object" "fontawesome_css" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/css/fontawesome.css"
  source       = "./assets/css/fontawesome.css"
  content_type = "text/css"
  etag         = filemd5("./assets/css/fontawesome.css")
}

resource "aws_s3_object" "owl_css" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/css/owl.css"
  source       = "./assets/css/owl.css"
  content_type = "text/css"
  etag         = filemd5("./assets/css/owl.css")
}

resource "aws_s3_object" "templatemo_villa_agency_css" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/css/templatemo-villa-agency.css"
  source       = "./assets/css/templatemo-villa-agency.css"
  content_type = "text/css"
  etag         = filemd5("./assets/css/templatemo-villa-agency.css")
}

# Upload JavaScript files
resource "aws_s3_object" "counter_js" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/js/counter.js"
  source       = "./assets/js/counter.js"
  content_type = "application/javascript"
  etag         = filemd5("./assets/js/counter.js")
}

resource "aws_s3_object" "custom_js" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/js/custom.js"
  source       = "./assets/js/custom.js"
  content_type = "application/javascript"
  etag         = filemd5("./assets/js/custom.js")
}

resource "aws_s3_object" "isotope_min_js" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/js/isotope.min.js"
  source       = "./assets/js/isotope.min.js"
  content_type = "application/javascript"
  etag         = filemd5("./assets/js/isotope.min.js")
}

resource "aws_s3_object" "owl_carousel_js" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/js/owl-carousel.js"
  source       = "./assets/js/owl-carousel.js"
  content_type = "application/javascript"
  etag         = filemd5("./assets/js/owl-carousel.js")
}

# Upload vendor files
resource "aws_s3_object" "bootstrap_css" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "vendor/bootstrap/css/bootstrap.min.css"
  source       = "./vendor/bootstrap/css/bootstrap.min.css"
  content_type = "text/css"
  etag         = filemd5("./vendor/bootstrap/css/bootstrap.min.css")
}

resource "aws_s3_object" "bootstrap_js" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "vendor/bootstrap/js/bootstrap.min.js"
  source       = "./vendor/bootstrap/js/bootstrap.min.js"
  content_type = "application/javascript"
  etag         = filemd5("./vendor/bootstrap/js/bootstrap.min.js")
}

resource "aws_s3_object" "jquery_js" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "vendor/jquery/jquery.js"
  source       = "./vendor/jquery/jquery.js"
  content_type = "application/javascript"
  etag         = filemd5("./vendor/jquery/jquery.js")
}

resource "aws_s3_object" "jquery_min_js" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "vendor/jquery/jquery.min.js"
  source       = "./vendor/jquery/jquery.min.js"
  content_type = "application/javascript"
  etag         = filemd5("./vendor/jquery/jquery.min.js")
}

# Upload image files
resource "aws_s3_object" "banner_01" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/banner-01.jpg"
  source       = "./assets/images/banner-01.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/banner-01.jpg")
}

resource "aws_s3_object" "banner_02" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/banner-02.jpg"
  source       = "./assets/images/banner-02.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/banner-02.jpg")
}

resource "aws_s3_object" "banner_03" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/banner-03.jpg"
  source       = "./assets/images/banner-03.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/banner-03.jpg")
}

resource "aws_s3_object" "contact_bg" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/contact-bg.jpg"
  source       = "./assets/images/contact-bg.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/contact-bg.jpg")
}

resource "aws_s3_object" "deal_01" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/deal-01.jpg"
  source       = "./assets/images/deal-01.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/deal-01.jpg")
}

resource "aws_s3_object" "deal_02" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/deal-02.jpg"
  source       = "./assets/images/deal-02.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/deal-02.jpg")
}

resource "aws_s3_object" "deal_03" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/deal-03.jpg"
  source       = "./assets/images/deal-03.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/deal-03.jpg")
}

resource "aws_s3_object" "email_icon" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/email-icon.png"
  source       = "./assets/images/email-icon.png"
  content_type = "image/png"
  etag         = filemd5("./assets/images/email-icon.png")
}

resource "aws_s3_object" "featured_icon" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/featured-icon.png"
  source       = "./assets/images/featured-icon.png"
  content_type = "image/png"
  etag         = filemd5("./assets/images/featured-icon.png")
}

resource "aws_s3_object" "featured" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/featured.jpg"
  source       = "./assets/images/featured.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/featured.jpg")
}

resource "aws_s3_object" "info_icon_01" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/info-icon-01.png"
  source       = "./assets/images/info-icon-01.png"
  content_type = "image/png"
  etag         = filemd5("./assets/images/info-icon-01.png")
}

resource "aws_s3_object" "info_icon_02" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/info-icon-02.png"
  source       = "./assets/images/info-icon-02.png"
  content_type = "image/png"
  etag         = filemd5("./assets/images/info-icon-02.png")
}

resource "aws_s3_object" "info_icon_03" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/info-icon-03.png"
  source       = "./assets/images/info-icon-03.png"
  content_type = "image/png"
  etag         = filemd5("./assets/images/info-icon-03.png")
}

resource "aws_s3_object" "info_icon_04" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/info-icon-04.png"
  source       = "./assets/images/info-icon-04.png"
  content_type = "image/png"
  etag         = filemd5("./assets/images/info-icon-04.png")
}

resource "aws_s3_object" "page_heading_bg" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/page-heading-bg.jpg"
  source       = "./assets/images/page-heading-bg.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/page-heading-bg.jpg")
}

resource "aws_s3_object" "phone_icon" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/phone-icon.png"
  source       = "./assets/images/phone-icon.png"
  content_type = "image/png"
  etag         = filemd5("./assets/images/phone-icon.png")
}

resource "aws_s3_object" "property_01" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/property-01.jpg"
  source       = "./assets/images/property-01.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/property-01.jpg")
}

resource "aws_s3_object" "property_02" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/property-02.jpg"
  source       = "./assets/images/property-02.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/property-02.jpg")
}

resource "aws_s3_object" "property_03" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/property-03.jpg"
  source       = "./assets/images/property-03.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/property-03.jpg")
}

resource "aws_s3_object" "property_04" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/property-04.jpg"
  source       = "./assets/images/property-04.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/property-04.jpg")
}

resource "aws_s3_object" "property_05" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/property-05.jpg"
  source       = "./assets/images/property-05.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/property-05.jpg")
}

resource "aws_s3_object" "property_06" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/property-06.jpg"
  source       = "./assets/images/property-06.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/property-06.jpg")
}

resource "aws_s3_object" "single_property" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/single-property.jpg"
  source       = "./assets/images/single-property.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/single-property.jpg")
}

resource "aws_s3_object" "video_bg" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/video-bg.jpg"
  source       = "./assets/images/video-bg.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/video-bg.jpg")
}

resource "aws_s3_object" "video_frame" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/images/video-frame.jpg"
  source       = "./assets/images/video-frame.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./assets/images/video-frame.jpg")
}

# Upload webfonts
resource "aws_s3_object" "fa_brands_400_ttf" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-brands-400.ttf"
  source       = "./assets/webfonts/fa-brands-400.ttf"
  content_type = "font/ttf"
  etag         = filemd5("./assets/webfonts/fa-brands-400.ttf")
}

resource "aws_s3_object" "fa_brands_400_woff2" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-brands-400.woff2"
  source       = "./assets/webfonts/fa-brands-400.woff2"
  content_type = "font/woff2"
  etag         = filemd5("./assets/webfonts/fa-brands-400.woff2")
}

resource "aws_s3_object" "fa_regular_400_ttf" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-regular-400.ttf"
  source       = "./assets/webfonts/fa-regular-400.ttf"
  content_type = "font/ttf"
  etag         = filemd5("./assets/webfonts/fa-regular-400.ttf")
}

resource "aws_s3_object" "fa_regular_400_woff2" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-regular-400.woff2"
  source       = "./assets/webfonts/fa-regular-400.woff2"
  content_type = "font/woff2"
  etag         = filemd5("./assets/webfonts/fa-regular-400.woff2")
}

resource "aws_s3_object" "fa_solid_900_ttf" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-solid-900.ttf"
  source       = "./assets/webfonts/fa-solid-900.ttf"
  content_type = "font/ttf"
  etag         = filemd5("./assets/webfonts/fa-solid-900.ttf")
}

resource "aws_s3_object" "fa_solid_900_woff2" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-solid-900.woff2"
  source       = "./assets/webfonts/fa-solid-900.woff2"
  content_type = "font/woff2"
  etag         = filemd5("./assets/webfonts/fa-solid-900.woff2")
}

resource "aws_s3_object" "fa_v4compatibility_ttf" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-v4compatibility.ttf"
  source       = "./assets/webfonts/fa-v4compatibility.ttf"
  content_type = "font/ttf"
  etag         = filemd5("./assets/webfonts/fa-v4compatibility.ttf")
}

resource "aws_s3_object" "fa_v4compatibility_woff2" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "assets/webfonts/fa-v4compatibility.woff2"
  source       = "./assets/webfonts/fa-v4compatibility.woff2"
  content_type = "font/woff2"
  etag         = filemd5("./assets/webfonts/fa-v4compatibility.woff2")
}

# Output the website endpoint
output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website_bucket.website_endpoint
}


output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}
