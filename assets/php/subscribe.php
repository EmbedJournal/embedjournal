<?php

    // Put your MailChimp API and List ID hehe
    $api_key = 'c2f4431b34483023531340a03dee7701-us7';

    // Let's start by including the MailChimp API wrapper
    include('./inc/MailChimp.php');
    // Then call/use the class
    use \DrewM\MailChimp\MailChimp;
    $MailChimp = new MailChimp($api_key);

    //foreach ($_POST as $key => $value) {
    //  file_put_contents('php://stderr', print_r($key . " = " . $value . "\n" , TRUE));
    //}


    if (array_key_exists('name', $_POST)) {
        // Landing page
        $list_id = '16e5ebc6de';
        $options = [
            'email_address' => $_POST['email'],
            'merge_fields'  => [ 'NAME'=>$_POST['name'] ],
            'status'        => 'pending',
        ];
    } else {
        // Post subscribe form
        $list_id = '9076c04fc2';
        $options = [
            'email_address' => $_POST['email'],
            'status'        => 'pending',
        ];
    }

    //file_put_contents('php://stderr', print_r("ID: " . $list_id . "\n", TRUE));

    // Submit subscriber data to MailChimp
    // For parameters doc, refer to: http://developer.mailchimp.com/documentation/mailchimp/reference/lists/members/
    // For wrapper's doc, visit: https://github.com/drewm/mailchimp-api
    $result = $MailChimp->post("lists/$list_id/members", $options);

    if ($MailChimp->success()) {
        // Success message
        echo "<p>Almost done!, we have sent an email to " . $_POST['email'] . ". Click on the confirmation link to complete your subscription</p>";
    } else {
        // Display error
        echo "<p>Something isn't right.. While trying to add you, we got back '" . $MailChimp->getLastError() . "'. Please include this message when you contact us.</p>";
        // Alternatively you can use a generic error message like:
        // echo "<h4>Please try again.</h4>";
    }
?>
