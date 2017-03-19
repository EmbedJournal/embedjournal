EmbedJournal Jekyll Template
============================

### Installation:

	* TBD in the near future.

### Notes:

* Collection names do not seem to support "-" in them, use "_" instead.
* collection names cannot be same as global variables (site.VARIABLE) as collections get get into into global scope (site.COLLECTION) as well.


Notes for AlphaWebLab:
----------------------

### TODO:

* Add 404.html. Large 404 with a :) in current theme looks good. Get something similar.
* Add a page to state that some lesser value contents have been removed page. Nothing fancy, perhaps some links later in time?
* Add next and previous buttons below post page like in embedjournal-old. Use double arrows as in pagination block.
* Add email validation, recaptcha and dummy input fields for mailchimp signup. See form below.

### Issues:

* Footer first link is treated as heading automatically. Make that a separate div.
* Tags in post page has some UI overlap.
* Author name in post page author widget is broken to next line before using the full line.
* Social icons (sidebar, author widget, author pages) don't have any hover action.
* Make post list page category link hover to underline text.
* Post page top right date clip sometimes overlaps text. Add a small margin around it.
* Footer about section remove hover underline. make it bright on hover. Same for all text links there.
* Numbered list typography has to be fixed. See, /glem-graphical-lcd-emulator-c/ & /contact/
* Block quotes are ave too small a font and has too much padding in the bottom. Fix this.
* Post page author widget link decoration has to be fixed.
* Fix comments card CSS. Should fit rest of the the theme, with white back and heading as "Comments"
* Fix size of image in sidebar post widgets.

### Resources:

	**Mailchimp Form:**
```html
<!-- Begin MailChimp Signup Form -->
<link href="//cdn-images.mailchimp.com/embedcode/classic-10_7.css" rel="stylesheet" type="text/css">
<style type="text/css">
	#mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
	/* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
	   We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="//embedjournal.us7.list-manage.com/subscribe/post?u=ca5f8bb3dc0dd541355131c0c&amp;id=9076c04fc2" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <div id="mc_embed_signup_scroll">
	
<div class="mc-field-group">
	<label for="mce-EMAIL">Email Address </label>
	<input type="email" value="" name="EMAIL" class="required email" id="mce-EMAIL">
</div>
	<div id="mce-responses" class="clear">
		<div class="response" id="mce-error-response" style="display:none"></div>
		<div class="response" id="mce-success-response" style="display:none"></div>
	</div>    <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
	<div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_ca5f8bb3dc0dd541355131c0c_9076c04fc2" tabindex="-1" value=""></div>
    <div class="clear"><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button"></div>
    </div>
</form>
</div>
<script type='text/javascript' src='//s3.amazonaws.com/downloads.mailchimp.com/js/mc-validate.js'></script><script type='text/javascript'>(function($) {window.fnames = new Array(); window.ftypes = new Array();fnames[0]='EMAIL';ftypes[0]='email';}(jQuery));var $mcj = jQuery.noConflict(true);</script>
<!--End mc_embed_signup-->
```