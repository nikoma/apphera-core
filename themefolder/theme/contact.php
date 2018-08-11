<?php
/**
 * PHP Contact form
 *
 * Add basic form validation: required fields & email address valid
 * Sends email to
 */
$email_to = 'YOUR-EMAIL-HERE'; // update to your email
$email_to_name = 'YOUR-NAME-HERE'; // update to your name
$form_message = '<p>Please use the form below to contact us.</p>';
$form_errors = array();
$form_values = $_POST; // Optionally change to $_GET & <form action="contact.php" method="get"> on form
$required_fields = array( // if any of these fields are blank are error will show
  'contact-name' => 'Name',
  'contact-email' => 'Email',
  'contact-message' => 'Message',
);

if (!empty($form_values)) {
  // Form was submitted, validate required fields
  if (!empty($required_fields)) {
    foreach ($required_fields as $required => $label) {
      if (empty($form_values[$required])) {
        $form_errors[$required] = "The $label field is required and cannot be left blank."; //Message to show use
      }
    }
  }
  
  if (!empty($form_values['contact-email'])) {
    // Email address submitted, validate it
    // Remove all illegal characters from email
    $email = filter_var($form_values['contact-email'], FILTER_SANITIZE_EMAIL);

    // Validate e-mail
    if (!filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
      // Valid, send email
      require 'assets/plugins/PHPMailer/PHPMailerAutoload.php';
      $mail = new PHPMailer;
      $mail->setFrom($email, $form_values['contact-name']);
      $mail->addAddress($email_to, $email_name);
      $mail->Subject = 'Contact form enquiry from ' . $form_values['contact-name'];
      $email_body = array();
      $email_body[] = '<strong>Email:</strong> ' . $form_values['contact-email'] .'<br />';
      $email_body[] = '<strong>Name:</strong> ' . $form_values['contact-name'] .'<br />';
      $email_body[] = '<strong>Message:</strong> ' . $form_values['contact-message'] .'<br />';
      $email_body[] = 'Email sent at '. date('r', time());
      $mail->msgHTML(implode('<br />', $email_body));
      
      if (!$mail->send()) {
        $form_errors[] = 'Error in sendng enquiry please email us at ' . $email_to . ' instead.';
      }
      else {
        $form_message = '<div class="alert alert-success" role="alert"><strong>Enquiry Successfully sent!</strong> Thank you we will get back to you as soon as possible.</div>';
      }      
    }
    else {
      // Invalid
      $form_errors['contact-email'] = 'The email address inputted is invalid.';
    }
  }
  
  // Make errors into message to user
  if (!empty($form_errors)) {
    $form_message = '<div class="alert alert-danger" role="alert"><strong>Error!</strong> The following errors have occurred submitting the form: <hr />' . implode('<br />', $form_errors) .'</div>';
  }  
}
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Contact | AppStrap Bootstrap Theme by Themelize.me</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
    <!-- @todo: fill with your company info or remove -->
    <meta name="description" content="">
    <meta name="author" content="Themelize.me">
    
    <!-- Bootstrap v4.0.0-beta.2 CSS via CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
    
    <!-- Plugins required on all pages NOTE: Additional non-required plugins are loaded ondemand as of AppStrap 2.5 -->
    
    <!-- Theme style -->
    <link href="assets/css/theme-style.min.css" rel="stylesheet">
    
    <!--Your custom colour override-->
    <link href="#" id="colour-scheme" rel="stylesheet">
    
    <!-- Your custom override -->
    <link href="assets/css/custom-style.css" rel="stylesheet">
    
    
    
    <!-- Optional: ICON SETS -->
    <!-- Iconset: Font Awesome 4.7.0 via CDN -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Iconset: flag icons - http://lipis.github.io/flag-icon-css/ -->
    <link href="assets/plugins/flag-icon-css/css/flag-icon.min.css" rel="stylesheet">
    <!-- Iconset: ionicons - http://ionicons.com/ -->
    <link href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet">
    <!-- Iconset: Linearicons - https://linearicons.com/free -->
    <link href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css" rel="stylesheet">
    
    
    <!-- Le fav and touch icons - @todo: fill with your icons or remove -->
    <link rel="shortcut icon" href="assets/assets/img/icons/favicon.png">
    <link rel="apple-touch-icon" sizes="114x114" href="assets/assets/img/icons/114x114.png">
    <link rel="apple-touch-icon" sizes="72x72" href="assets/assets/img/icons/72x72.png">
    <link rel="apple-touch-icon" href="assets/assets/img/icons/default.png">
    
    
    <!-- Google fonts -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Rambla:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Calligraffitti' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,700' rel='stylesheet' type='text/css'>
    
    <!--Plugin: Retina.js (high def image replacement) - @see: http://retinajs.com/-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/retina.js/1.3.0/retina.min.js"></script>
  </head>
  
  <!-- ======== @Region: body ======== -->
  <body class="page page-contact navbar-layout-default">
    
    <!-- @plugin: page loading indicator, delete to remove loader -->
    <div class="page-loader" data-toggle="page-loader"></div>
    
    <a href="#content" id="top" class="sr-only">Skip to content</a> 
    
    <!-- ======== @Region: #header ======== -->
    <div id="header">
      
      <!--Hidden Header Region-->
      <div class="header-hidden collapse">
        <div class="header-hidden-inner container">
          <div class="row">
            <div class="col-sm-6">
              <h3>
                About Us
              </h3>
              <p>Making the web a prettier place one template at a time! We make beautiful, quality, responsive Drupal & web templates!</p>
              <a href="about.html" class="btn btn-sm btn-primary">Find out more</a> 
            </div>
            <div class="col-sm-6">
              <!--@todo: replace with company contact details-->
              <h3>
                Contact Us
              </h3>
              <address>
                <p>
                  <abbr title="Phone"><i class="fa fa-phone"></i></abbr>
                  019223 8092344
                </p>
                <p>
                  <abbr title="Email"><i class="fa fa-envelope"></i></abbr>
                  info@themelize.me
                </p>
                <p>
                  <abbr title="Address"><i class="fa fa-home"></i></abbr>
                  Sunshine House, Sunville. SUN12 8LU.
                </p>
              </address>
            </div>
          </div>
        </div>
      </div>
      
      <!--Header upper region-->
      <div class="header-upper">
        <!--Show/hide trigger for #hidden-header -->
        <div id="header-hidden-link">
          <a href="#" title="Click me you'll get a surprise" class="show-hide" data-toggle="show-hide" data-target=".header-hidden"><i></i>Open</a>
        </div>
        <!-- all direct children of the .header-inner element will be vertically aligned with each other you can override all the behaviours using the flexbox utilities (flexbox.htm) All elements with .header-brand & .header-block-flex wrappers will automatically be aligned inline & vertically using flexbox, this can be overridden using the flexbox utilities (flexbox.htm) Use .header-block to stack elements within on small screen & "float" on larger screens use .order-first or/and .order-last classes to make an element show first or last within .header-inner or .headr-block elements -->
        <div class="header-inner container">
          <!--user menu-->
          <div class="header-block-flex order-1 mr-auto">
            <nav class="nav nav-sm header-block-flex">
              <a class="nav-link d-md-none" href="login.html"><i class="fa fa-user"></i></a>
              <a class="nav-link text-xs text-uppercase d-none d-md-block" href="#signup-modal" data-toggle="modal">Sign Up</a> <a class="nav-link text-xs text-uppercase d-none d-md-block" href="#login-modal" data-toggle="modal">Login</a> 
            </nav>
            <div class="header-divider header-divider-sm"></div>
            <!--language menu-->
            <div class="dropdown dropdowns-no-carets">
              <a href="#en" class="nav-link text-xs p-1 dropdown-toggle" data-toggle="dropdown"><i class="flag-icon flag-icon-gb"></i></a>
              <div class="dropdown-menu dropdown-menu-mini dropdown-menu-primary">
                <a href="#es" class="dropdown-item lang-es"><i class="flag-icon flag-icon-es"></i> Spanish</a>
                <a href="#pt" class="dropdown-item lang-pt"><i class="flag-icon flag-icon-pt"></i> Portguese</a>
                <a href="#cn" class="dropdown-item lang-cn"><i class="flag-icon flag-icon-cn"></i> Chinese</a>
                <a href="#se" class="dropdown-item lang-se"><i class="flag-icon flag-icon-se"></i> Swedish</a>
              </div>
            </div>
          </div>
          <!--social media icons-->
          <div class="nav nav-icons header-block order-12">
            <!--@todo: replace with company social media details-->
            <a href="#" class="nav-link"> <i class="fa fa-twitter-square icon-1x"></i> <span class="sr-only">Twitter</span> </a>
            <a href="#" class="nav-link"> <i class="fa fa-facebook-square icon-1x"></i> <span class="sr-only">Facebook</span> </a>
            <a href="#" class="nav-link"> <i class="fa fa-linkedin-square icon-1x"></i> <span class="sr-only">Linkedin</span> </a>
            <a href="#" class="nav-link"> <i class="fa fa-google-plus-square icon-1x"></i> <span class="sr-only">Google plus</span> </a>
          </div>
        </div>
      </div>
      <div data-toggle="sticky">
        
        <!--Header search region - hidden by default -->
        <div class="header-search collapse" id="search">
          <form class="search-form container">
            <input type="text" name="search" class="form-control search" value="" placeholder="Search">
            <button type="button" class="btn btn-link"><span class="sr-only">Search </span><i class="fa fa-search fa-flip-horizontal search-icon"></i></button>
            <button type="button" class="btn btn-link close-btn" data-toggle="search-form-close"><span class="sr-only">Close </span><i class="fa fa-times search-icon"></i></button>
          </form>
        </div>
        
        <!--Header & Branding region-->
        <div class="header">
          <!-- all direct children of the .header-inner element will be vertically aligned with each other you can override all the behaviours using the flexbox utilities (flexbox.htm) All elements with .header-brand & .header-block-flex wrappers will automatically be aligned inline & vertically using flexbox, this can be overridden using the flexbox utilities (flexbox.htm) Use .header-block to stack elements within on small screen & "float" on larger screens use .order-first or/and .order-last classes to make an element show first or last within .header-inner or .headr-block elements -->
          <div class="header-inner container">
            <!--branding/logo -->
            <div class="header-brand">
              <a class="header-brand-text" href="index.html" title="Home">
                <h1>
                  <span>App</span>Strap<span>.</span>
                </h1>
              </a>
              <div class="header-divider d-none d-lg-block"></div>
              <div class="header-slogan d-none d-lg-block">Bootstrap 4 Theme</div>
            </div>
            <!-- other header content -->
            <div class="header-block order-12">
              
              <!--Search trigger -->
              <a href="#search" class="btn btn-icon btn-link header-btn float-right order-11" data-toggle="search-form" data-target=".header-search"><i class="fa fa-search fa-flip-horizontal search-icon"></i></a>
              
              <!-- mobile collapse menu button - data-toggle="collapse" = default BS menu - data-toggle="jpanel-menu" = jPanel Menu - data-toggle="overlay" = Overlay Menu -->
              <a href="#top" class="btn btn-link btn-icon header-btn float-right d-lg-none" data-toggle="jpanel-menu" data-target=".navbar-main" data-direction="right"> <i class="fa fa-bars"></i> </a>
            </div>
            
            <div class="navbar navbar-expand-md">
              <!--everything within this div is collapsed on mobile-->
              <div class="navbar-main collapse">
                <!--main navigation-->
                <ul class="nav navbar-nav float-lg-right dropdown-effect-fade">
                  <!-- Homepages -->
                  
                  <!-- Elements/shortcodes -->
                  <li class="nav-item dropdown dropdown-mega-menu">
                    <a href="#" class="nav-link dropdown-toggle" id="indexs-drop" data-toggle="dropdown" data-hover="dropdown"> <i class="fa fa-home nav-link-icon"></i> <span class="d-none">Home</span> </a>
                    <!-- Dropdown Menu - mega menu-->
                    <div class="dropdown-menu">
                      <div class="row">
                        <div class="col-lg-6">
                          <h4 class="dropdown-header d-none d-lg-block mt-0">
                            Default Homepages
                          </h4>
                          <div class="row">
                            <div class="col-lg-6"> <a href="intro.html" class="dropdown-item">Intro</a> <a href="index.html" class="dropdown-item">Homepage (default)</a> <a href="index-static.html" class="dropdown-item">Homepage No Slider</a> <a href="index-boxed.html" class="dropdown-item">Homepage Boxed</a> <a href="index-promo-header.html" class="dropdown-item">Promo Header</a> <a href="index-coming-soon.html" class="dropdown-item">Coming Soon</a> </div>
                            <div class="col-lg-6"> <a href="index-coming-soon-newsletter.html" class="dropdown-item">Coming Soon with newsletter</a> <a href="index-onepager.html" class="dropdown-item">One Pager Slideshow</a> <a href="index-onepager-image.html" class="dropdown-item">One Pager Image</a> <a href="index-onepager-image-full-height.html" class="dropdown-item">One Pager Image Full Height</a> <a href="index-onepager-bg-slideshow.html" class="dropdown-item">One Pager Background Slideshow</a> </div>
                          </div>
                        </div>
                        <div class="col-lg-6">
                          <h4 class="dropdown-header d-none d-lg-block mt-0">
                            Niche Homepages
                          </h4>
                          <div class="row">
                            <div class="col-lg-6"> <a href="demo-travel-blog.html" class="dropdown-item">Travel Blog</a> <a href="index-event.html" class="dropdown-item">Event Homepage</a> <a href="index-gym.html" class="dropdown-item">Gym Homepage</a> <a href="index-jobs.html" class="dropdown-item">Jobs Homepage</a> <a href="index-corporate.html" class="dropdown-item">Corporate Homepage</a> </div>
                            <div class="col-lg-6"> <a href="index-restaurant.html" class="dropdown-item">Restaurant Homepage</a> <a href="index-photographer.html" class="dropdown-item">Photographer Homepage</a> <a href="index-freelancer-portfolio.html" class="dropdown-item">Freelancer Homepage</a> <a href="shop.html" class="dropdown-item">Shop Homepage</a> </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                  
                  <!-- Pages -->
                  <li class="nav-item dropdown active">
                    <a href="#" class="nav-link dropdown-toggle" id="pages-drop" data-toggle="dropdown" data-hover="dropdown">Pages</a> 
                    <!-- Menu -->
                    <div class="dropdown-menu">
                      <div class="dropdown dropdown-submenu">
                        <a href="about.html" class="dropdown-item dropdown-toggle" id="about-drop" data-toggle="dropdown" data-hover="dropdown" data-close-others="false">About</a> 
                        <!-- Dropdown Menu -->
                        <div class="dropdown-menu" role="menu" aria-labelledby="about-drop"> <a href="about.html" class="dropdown-item">About Us Basic</a> <a href="about-extended.html" class="dropdown-item">About Us Extended</a> <a href="about-me.html" class="dropdown-item">About Me</a> <a href="team.html" class="dropdown-item">Team List</a> <a href="team-grid.html" class="dropdown-item">Team Grid</a> <a href="team-member.html" class="dropdown-item">Team Member</a> <a href="contact.html" class="dropdown-item active">Contact</a> <a href="contact.php" class="dropdown-item active">Contact (PHP)</a> </div>
                      </div>
                      <div class="dropdown dropdown-submenu">
                        <a href="blog.html" class="dropdown-item dropdown-toggle" id="blog-drop" data-toggle="dropdown" data-hover="dropdown" data-close-others="false">Blog</a> 
                        <!-- Dropdown Menu -->
                        <div class="dropdown-menu"> <a href="blog.html" class="dropdown-item">Blog List Right Sidebar</a> <a href="blog-leftbar.html" class="dropdown-item">Blog List Left Sidebar</a> <a href="blog-timeline.html" class="dropdown-item">Blog List Timeline</a> <a href="blog-grid.html" class="dropdown-item">Blog List Grid</a> <a href="blog-post.html" class="dropdown-item">Blog Post</a> <a href="blog-post-video.html" class="dropdown-item">Blog Post With Video</a> <a href="blog-post-slideshow.html" class="dropdown-item">Blog Post With Slideshow</a> <a href="blog-post-audio.html" class="dropdown-item">Blog Post With Audio Clip</a> </div>
                      </div>
                      <div class="dropdown dropdown-submenu">
                        <a href="pricing.html" class="dropdown-item dropdown-toggle" id="pricing-drop" data-toggle="dropdown" data-hover="dropdown" data-close-others="false">Pricing</a> 
                        <!-- pricing pages -->
                        <div class="dropdown-menu"> <a href="pricing.html" class="dropdown-item">Pricing Plans</a> <a href="pricing-tables.html" class="dropdown-item">Comparison Tables</a> </div>
                      </div>
                      <div class="dropdown dropdown-submenu">
                        <a href="timeline.html" class="dropdown-item dropdown-toggle" id="timeline-drop" data-toggle="dropdown" data-hover="dropdown" data-close-others="false">Timeline</a> 
                        <!-- timelines -->
                        <div class="dropdown-menu" role="menu" aria-labelledby="timeline-drop"> <a href="timeline.html" class="dropdown-item">Timeline Default</a> <a href="timeline-left.html" class="dropdown-item">Timeline Left</a> <a href="timeline-right.html" class="dropdown-item">Timeline Right</a> <a href="timeline-stacked.html" class="dropdown-item">Timeline Stacked</a> </div>
                      </div>
                      <a href="customers.html" class="dropdown-item">Customers</a> <a href="features.html" class="dropdown-item">Features/Services</a> <a href="login.html" class="dropdown-item">Login</a> <a href="signup.html" class="dropdown-item">Sign Up</a> <a href="starter.html" class="dropdown-item">Starter Snippets</a> <a href="404.html" class="dropdown-item">404 Error</a> 
                    </div>
                  </li>
                  
                  <!-- Features -->
                  <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" id="more-drop" data-toggle="dropdown" data-hover="dropdown">Features</a> 
                    <!-- Dropdown Menu -->
                    <div class="dropdown-menu">
                      <div class="dropdown dropdown-submenu dropdown-menu-left">
                        <a href="headers.html" class="dropdown-item dropdown-toggle" id="headers-drop" data-toggle="dropdown" data-hover="dropdown" data-close-others="false">Header Variations (18)</a> 
                        <!-- Header variations -->
                        <div class="dropdown-menu" role="menu" aria-labelledby="headers-drop"> <a href="header-elements.html" class="dropdown-item">Header Elements</a> <a href="header-offcanvas.html" class="dropdown-item">Header Off Canvas</a> <a href="header-collapse-menu.html" class="dropdown-item">Header Collapse Menu</a> <a href="header-overlay-menu.html" class="dropdown-item">Header Overlay Menu</a> <a href="header-collapse-menu-responsive.html" class="dropdown-item">Header Responsive Collapse Menu</a> <a href="header-fullwidth.html" class="dropdown-item">Header Full Width</a> <a href="header-navbar-below.html" class="dropdown-item">Header Navbar Below</a> <a href="header-compact.html" class="dropdown-item">Header Compact</a> <a href="header-dark.html" class="dropdown-item">Header Dark</a> <a href="header-primary.html" class="dropdown-item">Header Primary</a> <a href="header-transparent.html" class="dropdown-item">Header Transparent</a> <a href="header-transparent-dark.html" class="dropdown-item">Header Transparent Dark</a> <a href="header-transparent-primary.html" class="dropdown-item">Header Transparent Primary</a> <a href="header-translucent.html" class="dropdown-item">Header Translucent</a> <a href="header-translucent-dark.html" class="dropdown-item">Header Translucent Dark</a> <a href="header-translucent-primary.html" class="dropdown-item">Header Translucent Primary</a> <a href="header-nav-left.html" class="dropdown-item">Header Nav Left</a> <a href="header-nav-fullheight.html" class="dropdown-item">Header Nav Full Height</a> <a href="header-bottom.html" class="dropdown-item">Header Bottom</a> </div>
                      </div>
                      <div class="dropdown dropdown-submenu dropdown-menu-left">
                        <a href="headers.html" class="dropdown-item dropdown-toggle" id="footers-drop" data-toggle="dropdown" data-hover="dropdown" data-close-others="false">Footer Variations (5)</a> 
                        <!-- Header variations -->
                        <div class="dropdown-menu" role="menu" aria-labelledby="footers-drop"> <a href="footer-light.html" class="dropdown-item">Footer Light</a> <a href="footer-compact.html" class="dropdown-item">Footer Compact</a> <a href="footer-menus.html" class="dropdown-item">Footer Menus</a> <a href="footer-compact-light.html" class="dropdown-item">Footer Compact Light</a> <a href="footer-menus-light.html" class="dropdown-item">Footer Menus Light</a> </div>
                      </div>
                      <div class="dropdown dropdown-submenu dropdown-menu-left">
                        <a href="sliders.html" class="dropdown-item dropdown-toggle" id="slider-drop" data-toggle="dropdown" data-hover="dropdown" data-close-others="false">Sliders</a> 
                        <!-- Sliders -->
                        <div class="dropdown-menu">
                          <!--Slider Revolution -->
                          <h4 class="dropdown-header">
                            Slider Revolution
                          </h4>
                          <a href="slider-revolution-default.html" class="dropdown-item">Default</a> <a href="slider-revolution-full.html" class="dropdown-item">Full Width</a> <a href="slider-revolution-behind.html" class="dropdown-item">Behind Navbar</a> <a href="slider-revolution-boxed.html" class="dropdown-item">Boxed</a> 
                          <!--Backstretch Slider-->
                          <h4 class="dropdown-header">
                            Backstretch
                          </h4>
                          <a href="backstretch.html" class="dropdown-item">Background Slideshow</a> <a href="backstretch-boxed.html" class="dropdown-item">Boxed Background Slideshow</a> 
                          <!--Flexslider-->
                          <h4 class="dropdown-header">
                            Flexslider
                          </h4>
                          <a href="flexslider-default.html" class="dropdown-item">Default</a> <a href="flexslider-full.html" class="dropdown-item">Full Width</a> <a href="flexslider-behind.html" class="dropdown-item">Behind Navbar</a> <a href="flexslider-boxed.html" class="dropdown-item">Boxed</a> 
                        </div>
                      </div>
                      <a href="grid.html" class="dropdown-item">Grid System</a> <a href="flexbox.html" class="dropdown-item">Flexbox!</a> <a href="colours.html" class="dropdown-item">Theme Colours</a> 
                    </div>
                  </li>
                  
                  <!-- Shop megamenu -->
                  <li class="nav-item dropdown dropdown-mega-menu dropdown-mega-menu-75">
                    <a href="#" class="nav-link dropdown-toggle" id="shop-drop" data-toggle="dropdown" data-hover="dropdown">Shop</a> 
                    <!-- Dropdown Menu - mega menu-->
                    <div class="dropdown-menu dropdown-menu-right">
                      <div class="row">
                        <div class="col-lg-6">
                          <h3 class="dropdown-header mt-0 pt-0">
                            Pages
                          </h3>
                          <a href="shop.html" class="dropdown-item">Shop Homepage</a> <a href="shop-cart.html" class="dropdown-item">Cart</a> <a href="shop-checkout.html" class="dropdown-item">Checkout</a> <a href="shop-confirmation.html" class="dropdown-item">Confirmation</a> <a href="shop-grid.html" class="dropdown-item">Products Grid</a> <a href="shop-list.html" class="dropdown-item">Products List</a> <a href="shop-product.html" class="dropdown-item">Product View</a> 
                        </div>
                        <div class="col-lg-6 d-none d-lg-block">
                          <h3 class="dropdown-header mt-0 pt-0">
                            Widget <span class="badge badge-primary text-uppercase">Hot</span>
                          </h3>
                          <div class="dropdown-widget">
                            <!-- Shop product carousel Uses Owl Carousel plugin All options here are customisable from the data-owl-carousel-settings="{OBJECT}" item via data- attributes: http://www.owlgraphic.com/owlcarousel/#customizing ie. data-settings="{"items": "4", "lazyLoad":"true", "navigation":"true"}" -->
                            <div class="products-carousel owl-nav-over" data-toggle="owl-carousel" data-owl-carousel-settings='{"items": 1,"responsive":{"0":{"items":1,"nav":true, "dots":false}}}'>
                              <a href="#">
                                <img src="assets/img/shop/jacket-1.jpg" alt="Item 1 image" class="lazyOwl img-fluid" />
                              </a>
                              <a href="#">
                                <img src="assets/img/shop/jacket-2.jpg" alt="Item 2 image" class="lazyOwl img-fluid" />
                              </a>
                              <a href="#">
                                <img src="assets/img/shop/jacket-3.jpg" alt="Item 3 image" class="lazyOwl img-fluid" />
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                  
                  <!-- Elements/shortcodes -->
                  <li class="nav-item dropdown dropdown-mega-menu">
                    <a href="#" class="nav-link dropdown-toggle" id="elements-drop" data-toggle="dropdown" data-hover="dropdown">Elements</a> 
                    <!-- Dropdown Menu - mega menu-->
                    <div class="dropdown-menu">
                      <h4 class="dropdown-header d-none d-lg-block mt-0">
                        34 pages of elements/snippets <i class="new-tag">Updated!</i>
                      </h4>
                      <div class="row">
                        <div class="col-lg-3"> <a href="elements-alerts.html" class="dropdown-item">Alerts</a> <a href="elements-animation.html" class="dropdown-item">Animations</a> <a href="elements-badges.html" class="dropdown-item">Badges</a> <a href="elements-button-groups.html" class="dropdown-item">Button Groups</a> <a href="elements-buttons.html" class="dropdown-item">Buttons</a> <a href="elements-cards.html" class="dropdown-item">Cards</a> <a href="elements-carousels.html" class="dropdown-item">Carousels</a> <a href="elements-collapse.html" class="dropdown-item">Collapse / Accordions</a> <a href="elements-colour-utils.html" class="dropdown-item">Colours Utils</a> </div>
                        <div class="col-lg-3"> <a href="elements-counters.html" class="dropdown-item">Counters</a> <a href="elements-ctas.html" class="dropdown-item">Call To Action Blocks</a> <a href="elements-dividers.html" class="dropdown-item">Dividers</a> <a href="elements-dropdowns.html" class="dropdown-item">Dropdowns</a> <a href="elements-forms.html" class="dropdown-item">Forms</a> <a href="elements-forms-input-groups.html" class="dropdown-item">Forms Input Groups</a> <a href="elements-icons.html" class="dropdown-item">Icons</a> <a href="elements-icons-flags.html" class="dropdown-item">Icons: Flags</a> <a href="elements-icons-fontawesome.html" class="dropdown-item">Icons: Font Awesome</a> </div>
                        <div class="col-lg-3"> <a href="elements-icons-ionicons.html" class="dropdown-item">Icons: Ionicons</a> <a href="elements-icons-linearicons.html" class="dropdown-item">Icons: Linearicons</a> <a href="elements-list-groups.html" class="dropdown-item">List Groups</a> <a href="elements-modals.html" class="dropdown-item">Modals</a> <a href="elements-modals-onload.html" class="dropdown-item">Modals Onload</a> <a href="elements-navs.html" class="dropdown-item">Navs</a> <a href="elements-navs-tabbable.html" class="dropdown-item">Tabbable Navs</a> <a href="elements-overlays.html" class="dropdown-item">Overlays</a> <a href="elements-progressbars.html" class="dropdown-item">Progress Bars</a> </div>
                        <div class="col-lg-3"> <a href="elements-spacers.html" class="dropdown-item">Spacers</a> <a href="elements-tables.html" class="dropdown-item">Tables</a> <a href="elements-tooltips-popovers.html" class="dropdown-item">Tooltips & Popovers</a> <a href="elements-type-effect.html" class="dropdown-item">Type Effect</a> <a href="elements-typography.html" class="dropdown-item">Typography</a> <a href="elements-utils.html" class="dropdown-item">Utilities</a> <a href="elements-video-blocks.html" class="dropdown-item">Video Blocks</a> </div>
                      </div>
                    </div>
                  </li>
                  
                  <!-- Mega menu example -->
                  <li class="nav-item dropdown dropdown-persist dropdown-mega-menu dropdown-mega-menu-50">
                    <a href="#" class="nav-link dropdown-toggle" id="megamenu-drop" data-toggle="dropdown" data-hover="dropdown">Mega Menu</a> 
                    <!-- Dropdown Menu - Mega Menu -->
                    <div class="dropdown-menu dropdown-menu-right">
                      <!-- Nav tabs -->
                      <ul class="nav nav-pills nav-pills-border-bottom-inside flex-column flex-lg-row" role="tablist">
                        <li class="nav-item"> <a class="nav-link p-3 active text-center font-weight-bold" data-toggle="tab" data-target=".menu-tab-1" role="tab">Mega Menu Tab 1</a> </li>
                        <li class="nav-item"> <a class="nav-link p-3 text-center font-weight-bold" data-toggle="tab" data-target=".menu-tab-2" role="tab">Mega Menu Tab 2</a> </li>
                      </ul>
                      <!-- Tab panes -->
                      <div class="tab-content py-3">
                        <div class="tab-pane active show menu-tab-1" role="tabpanel">
                          <div class="row text-center">
                            <div class="col-lg-4 py-2">
                              <i class="fa fa-tachometer icon-5x text-primary" data-animate="fadeIn" data-animate-delay="0.1"></i> 
                              <h5 class="mt-2">
                                Fully Optimized
                              </h5>
                              <p>Aliquip at euismod pecus.</p>
                            </div>
                            <div class="col-lg-4 py-2">
                              <i class="fa fa-wrench icon-5x text-primary" data-animate="fadeIn" data-animate-delay="0.2"></i> 
                              <h5 class="mt-2">
                                Free Support
                              </h5>
                              <p>Aliquip comis euismod verto.</p>
                            </div>
                            <div class="col-lg-4 py-2">
                              <i class="fa fa-rocket icon-5x text-primary" data-animate="fadeIn" data-animate-delay="0.3"></i> 
                              <h5 class="mt-2">
                                Free Upgrades
                              </h5>
                              <p>Adipiscing metuo nulla quis singularis.</p>
                            </div>
                          </div>
                        </div>
                        <div class="tab-pane menu-tab-2" role="tabpanel">
                          <div class="row text-center">
                            <div class="col-lg-4 py-2">
                              <i class="fa fa-line-chart icon-5x text-primary" data-animate="fadeIn" data-animate-delay="0.4"></i> 
                              <h5 class="mt-2">
                                99.9% Uptime
                              </h5>
                              <p>Cogo enim et euismod humo oppeto plaga saepius.</p>
                            </div>
                            <div class="col-lg-4 py-2">
                              <i class="fa fa-smile-o icon-5x text-primary" data-animate="fadeIn" data-animate-delay="0.5"></i> 
                              <h5 class="mt-2">
                                Multiuser
                              </h5>
                              <p>Damnum occuro plaga proprius ut vel virtus.</p>
                            </div>
                            <div class="col-lg-4 py-2">
                              <i class="fa fa-plug icon-5x text-primary" data-animate="fadeIn" data-animate-delay="0.6"></i> 
                              <h5 class="mt-2">
                                Plug n play
                              </h5>
                              <p>Abigo exputo obruo. Abigo defui dolus enim erat ille iusto praesent si veniam.</p>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
              <!--/.navbar-collapse -->
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- ======== @Region: #content ======== -->
    <div id="content">
      <div class="container">
        <div class="row">
          <!-- sidebar -->
          <div class="col-md-3">
            
            <!-- Sections Menu-->
            <div class="nav-section-menu">
              <div class="nav nav-list">
                <span class="nav-header">In This Section</span> 
                <a href="about.html" class="nav-link first">
                  About Us 
                  <small>Basic Version</small>
                  <i class="fa fa-angle-right"></i>
                </a>
                <a href="about-extended.html" class="nav-link">
                  About Us 
                  <small>Extended Version</small>
                  <i class="fa fa-angle-right"></i>
                </a>
                <a href="about-me.html" class="nav-link">
                  About Me 
                  <small>More About Me</small>
                  <i class="fa fa-angle-right"></i>
                </a>
                <a href="team.html" class="nav-link">
                  The Team 
                  <small>Team List</small>
                  <i class="fa fa-angle-right"></i>
                </a>
                <a href="team-grid.html" class="nav-link">
                  The Team 
                  <small>Team Grid</small>
                  <i class="fa fa-angle-right"></i>
                </a>
                <a href="team-member.html" class="nav-link">
                  Team Member 
                  <small>Individual Display</small>
                  <i class="fa fa-angle-right"></i>
                </a>
                <a href="contact.html" class="nav-link">
                  Contact Us
                  <small>How to get in touch</small>
                  <i class="fa fa-angle-right"></i>
                </a>
                <a href="contact.php" class="nav-link active">
                  Contact Us (PHP)
                  <small>How to get in touch</small>
                  <i class="fa fa-angle-right"></i>
                </a>
              </div>
            </div>
          </div>
          <!--main content-->
          <div class="col-md-9">
            <h2 class="title-divider">
              <span>Contact <span class="font-weight-normal text-muted">Us</span></span>
              <small>Ways To Get In Touch</small>
            </h2>

            <?php echo !empty($form_message) ? $form_message : ''; // Show message to user, errors or success ?>
            
            <!-- The form: submits to itself -->
            <form id="contact-form" action="contact.php" method="POST">
              <div class="form-group<?php echo !empty($form_errors['contact-name']) ? '' : ''; // add danger class is error on field ?>">
                <label class="sr-only" for="contact-name">Name</label>
                <input type="text" value="<?php echo !empty($form_values['contact-name']) ? $form_values['contact-name'] : ''; ?>" class="form-control<?php echo !empty($form_errors['contact-name']) ? ' is-invalid' : ''; // add danger class is error on field ?>" name="contact-name" id="contact-name" placeholder="Name">
                <small id="contact-name-help" class="form-text text-muted">First and last names.</small>
              </div>
              <div class="form-group<?php echo !empty($form_errors['contact-email']) ? ' is-invalid' : ''; // add danger class is error on field ?>">
                <label class="sr-only" for="contact-email">Email</label>
                <input type="email" value="<?php echo !empty($form_values['contact-email']) ? $form_values['contact-email'] : ''; ?>" class="form-control<?php echo !empty($form_errors['contact-email']) ? ' is-invalid' : ''; // add danger class is error on field ?>" name="contact-email" id="contact-email" placeholder="Email">
                <small id="contact-email-help" class="form-text text-muted">We'll never share your email with anyone else.</small>
              </div>
              <div class="form-group<?php echo !empty($form_errors['contact-message']) ? ' is-invalid' : ''; // add danger class is error on field ?>">
                <label class="sr-only" for="contact-message">Message</label>
                <textarea rows="12" class="form-control<?php echo !empty($form_errors['contact-message']) ? ' is-invalid' : ''; // add danger class is error on field ?>" name="contact-message" id="contact-message" placeholder="Message"><?php echo !empty($form_values['contact-message']) ? $form_values['contact-message'] : ''; ?></textarea>
                <small id="contact-message-help" class="form-text text-muted">Your message and details.</small>
              </div>
              <input type="submit" class="btn btn-primary" value="Send Message">
            </form>            
            
          </div>
        </div>
      </div>
    </div>
    
    <!-- ======== @Region: #content-below ======== -->
    <div id="content-below">
      <!-- Awesome features call to action -->
      <div class="bg-primary text-white py-4">
        <div class="container">
          <div class="row text-center text-lg-left">
            <div class="col-12 col-lg-7 py-2">
              <h2 class="text-uppercase font-weight-bold mt-0 mb-2">
                <span class="text-shadow">Awesome</span> <span class="text-primary-darkend">Features</span>
              </h2>
              <h5 class="text-faded">
                99.9% Uptime <span class="text-primary-darkend font-weight-bold px-lg-1">/</span> Free Upgrades <span class="text-primary-darkend font-weight-bold px-lg-1">/</span> Fully Responsive <span class="text-primary-darkend font-weight-bold px-lg-1">/</span> Bug Free 
              </h5>
            </div>
            <div class="col-12 col-lg-5 py-2 text-lg-right">
              <a href="https://wrapbootstrap.com/theme/appstrap-responsive-website-template-WB0C6D0H4" class="btn btn-lg btn-primary btn-invert btn-rounded py-3 px-4">Get AppStrap Today<i class="fa fa-arrow-right ml-2"></i></a>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- ======== @Region: #footer ======== -->
    <footer id="footer" class="p-0">
      <div class="container pt-6 pb-5">
        <div class="row">
          <div class="col-md-4">
            <!--@todo: replace with company contact details-->
            <h4 class="text-uppercase text-white">
              Contact Us
            </h4>
            <address>
              <ul class="list-unstyled">
                <li>
                  <abbr title="Phone"><i class="fa fa-phone fa-fw"></i></abbr>
                  019223 8092344
                </li>
                <li>
                  <abbr title="Email"><i class="fa fa-envelope fa-fw"></i></abbr>
                  info@appstraptheme.com
                </li>
                <li>
                  <abbr title="Address"><i class="fa fa-home fa-fw"></i></abbr>
                  Sunshine House, Sunville. SUN12 8LU.
                </li>
              </ul>
            </address>
          </div>
          
          <div class="col-md-4">
            <h4 class="text-uppercase text-white">
              About Us
            </h4>
            <p>Making the web a prettier place one template at a time! We make beautiful, quality, responsive Drupal & web templates!</p>
          </div>
          
          <div class="col-md-4">
            <h4 class="text-uppercase text-white">
              Newsletter
            </h4>
            <p>Stay up to date with our latest news and product releases by signing up to our newsletter.</p>
            <!--@todo: replace with mailchimp code-->
            <form>
              <div class="input-group">
                <label class="sr-only" for="email-field">Email</label>
                <input type="text" class="form-control" id="email-field" placeholder="Email">
                <span class="input-group-btn">
                  <button class="btn btn-primary" type="button">Go!</button>
                </span>
              </div>
            </form>
          </div>
        </div>
        
      </div>
      <hr class="my-0 hr-blank op-2" />
      <!--@todo: replace with company copyright details-->
      <div class="bg-inverse-dark text-sm py-3">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <p class="mb-0">Site template by <a href="appstraptheme.com" class="footer-link">AppStrap</a> | Copyright 2017 &copy; AppStrap</p>
            </div>
            <div class="col-md-6">
              <ul class="list-inline footer-links float-md-right mb-0">
                <li class="list-inline-item"><a href="#">Terms</a></li>
                <li class="list-inline-item"><a href="#">Privacy</a></li>
                <li class="list-inline-item"><a href="#">Contact Us</a></li>
              </ul>
            </div>
          </div>
          <a href="#top" class="btn btn-icon btn-inverse pos-fixed pos-b pos-r mr-3 mb-3 scroll-state-hidden" title="Back to top" data-scroll="scroll-state"><i class="fa fa-chevron-up"></i></a>
        </div>
      </div>
    </footer>
    <!-- Style switcher - demo only - @todo: remove in production -->
    <div class="colour-switcher">
      <a href="#" class="colour-switcher-toggle" data-toggle="class" data-target=".colour-switcher"> <i class="fa fa-paint-brush"></i> </a>
      <h5 class="text-uppercase my-0">
        Theme Colours
      </h5>
      <hr />
      <div class="theme-colours"> <a href="#green" class="green active" data-toggle="tooltip" data-placement="right" data-original-title="Green (Default)">Green</a> <a href="#red" class="red" data-toggle="tooltip" data-placement="right" data-original-title="Red">Red</a> <a href="#blue" class="blue" data-toggle="tooltip" data-placement="right" data-original-title="Blue">Blue</a> <a href="#purple" class="purple" data-toggle="tooltip" data-placement="right" data-original-title="Purple">Purple</a> <a href="#pink" class="pink" data-toggle="tooltip" data-placement="right" data-original-title="Pink">Pink</a> <a href="#orange" class="orange" data-toggle="tooltip" data-placement="right" data-original-title="Orange">Orange</a> <a href="#lime" class="lime" data-toggle="tooltip" data-placement="right" data-original-title="Lime">Lime</a> <a href="#blue-dark" class="blue-dark" data-toggle="tooltip" data-placement="right" data-original-title="Blue-dark">Blue-dark</a> <a href="#red-dark" class="red-dark" data-toggle="tooltip" data-placement="right" data-original-title="Red-dark">Red-dark</a> <a href="#brown" class="brown" data-toggle="tooltip" data-placement="right" data-original-title="Brown">Brown</a> <a href="#cyan-dark" class="cyan-dark" data-toggle="tooltip" data-placement="right" data-original-title="Cyan-dark">Cyan-dark</a> <a href="#yellow" class="yellow" data-toggle="tooltip" data-placement="right" data-original-title="Yellow">Yellow</a> <a href="#slate" class="slate" data-toggle="tooltip" data-placement="right" data-original-title="Slate">Slate</a> <a href="#olive" class="olive" data-toggle="tooltip" data-placement="right" data-original-title="Olive">Olive</a> <a href="#teal" class="teal" data-toggle="tooltip" data-placement="right" data-original-title="Teal">Teal</a> <a href="#green-bright" class="green-bright" data-toggle="tooltip" data-placement="right" data-original-title="Green-bright">Green-bright</a> </div>
      <hr />
      <p class="text-xs text-muted">Cookies are NOT enabled so colour selection is not persistent.</p>
      <p class="text-xs my-0"><a href="index.html">Back to main homepage</a></p>
    </div>
    <!--Hidden elements - excluded from jPanel Menu on mobile-->
    <div class="hidden-elements jpanel-menu-exclude">
      <!--@modal - signup modal-->
      <div class="modal fade" id="signup-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">
                Sign Up
              </h4>
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
              <form action="signup.html">
                <div class="form-group">
                  <h5>
                    Price Plan
                  </h5>
                  <select class="form-control">
                    <option>Basic</option>
                    <option>Pro</option>
                    <option>Pro +</option>
                  </select>
                </div>
                <hr />
                
                <h5>
                  Account Information
                </h5>
                <div class="form-group">
                  <label class="sr-only" for="signup-first-name">First Name</label>
                  <input type="text" class="form-control" id="signup-first-name" placeholder="First name">
                </div>
                <div class="form-group">
                  <label class="sr-only" for="signup-last-name">Last Name</label>
                  <input type="text" class="form-control" id="signup-last-name" placeholder="Last name">
                </div>
                <div class="form-group">
                  <label class="sr-only" for="signup-username">Userame</label>
                  <input type="text" class="form-control" id="signup-username" placeholder="Username">
                </div>
                <div class="form-group">
                  <label class="sr-only" for="signup-email">Email address</label>
                  <input type="email" class="form-control" id="signup-email" placeholder="Email address">
                </div>
                <div class="form-group">
                  <label class="sr-only" for="signup-password">Password</label>
                  <input type="password" class="form-control" id="signup-password" placeholder="Password">
                </div>
                <div class="form-check">
                  <label class="form-check-label">
                    <input type="checkbox" value="term" class="form-check-input">
                    I agree with the Terms and Conditions. 
                  </label>
                </div>
                <hr />
                <button class="btn btn-primary" type="submit">Sign up</button>
              </form>
            </div>
            <div class="modal-footer">
              <small>Already signed up? <a href="login.html">Login here</a>.</small>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
      
      <!--@modal - login modal-->
      <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">
                Login
              </h4>
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
              <form action="login.html">
                <div class="form-group">
                  <label class="sr-only" for="login-email">Email</label>
                  <input type="email" id="login-email" class="form-control email" placeholder="Email">
                </div>
                <div class="form-group">
                  <label class="sr-only" for="login-password">Password</label>
                  <input type="password" id="login-password" class="form-control password" placeholder="Password">
                </div>
                <button type="button" class="btn btn-primary">Login</button>
              </form>
            </div>
            <div class="modal-footer">
              <small>Not a member? <a href="#" class="signup">Sign up now!</a></small>
              <br />
              <small><a href="#">Forgotten password?</a></small>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
    </div>
    
    
    <!--jQuery 3.2.1 via CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <!-- Popper 1.9.3 via CDN, needed for Bootstrap Tooltips & Popovers -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.9.3/umd/popper.min.js"></script>
    
    <!-- Bootstrap v4.0.0-beta.2 JS via CDN -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
    
    
    <!-- JS plugins required on all pages NOTE: Additional non-required plugins are loaded ondemand as of AppStrap 2.5 To disable this and load plugin assets manually simple add data-plugins-manual=true to the body tag -->
    
    <!--Custom scripts & AppStrap API integration -->
    <script src="assets/js/custom-script.js"></script>
    <!--AppStrap scripts mainly used to trigger libraries/plugins -->
    <script src="assets/js/script.min.js"></script>
  </body>
</html>