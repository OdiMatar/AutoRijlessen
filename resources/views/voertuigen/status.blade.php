<x-layout :title="$title">
    <meta http-equiv="refresh" content="3; url={{ $redirectUrl }}">

    <section class="status-page">
        <div class="status-message">
            {{ $message }}
        </div>
    </section>
</x-layout>
