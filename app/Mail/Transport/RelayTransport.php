<?php

namespace App\Mail\Transport;

use Illuminate\Support\Facades\Http;
use RuntimeException;
use Symfony\Component\Mailer\SentMessage;
use Symfony\Component\Mailer\Transport\AbstractTransport;

class RelayTransport extends AbstractTransport
{
    public function __construct(
        private readonly string $url,
        private readonly string $token,
        private readonly int $timeout = 30,
    ) {
        parent::__construct();
    }

    public function __toString(): string
    {
        return 'relay';
    }

    protected function doSend(SentMessage $message): void
    {
        if ($this->url === '' || $this->token === '') {
            throw new RuntimeException('SMTP relay no configurado. Revisa SMTP_RELAY_URL y SMTP_RELAY_TOKEN.');
        }

        $envelope = $message->getEnvelope();
        $response = Http::timeout($this->timeout)
            ->withToken($this->token)
            ->acceptJson()
            ->asJson()
            ->post($this->url, [
                'raw_mime' => base64_encode($message->toString()),
                'from' => $envelope->getSender()->getAddress(),
                'to' => array_map(
                    fn ($address): string => $address->getAddress(),
                    $envelope->getRecipients(),
                ),
            ]);

        if ($response->failed()) {
            $message = $response->json('message') ?: $response->body();
            throw new RuntimeException('SMTP relay error: '.$message);
        }
    }
}
