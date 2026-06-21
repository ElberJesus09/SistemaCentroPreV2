<?php

test('the public home is available to guests', function () {
    $response = $this->get('/');

    $response->assertOk();
});
