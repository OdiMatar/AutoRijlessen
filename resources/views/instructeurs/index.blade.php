<x-layout title="Instructeurs in dienst">
    <section class="page-heading">
        <div>
            <h1>Instructeurs in dienst</h1>
            <p class="meta-line">Aantal instructeurs: [{{ count($instructeurs) }}]</p>
        </div>
    </section>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>Naam</th>
                    <th>Mobiel</th>
                    <th>Datum in dienst</th>
                    <th>Aantal sterren</th>
                    <th>Voertuigen</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($instructeurs as $instructeur)
                    <tr>
                        <td>{{ $instructeur->VolledigeNaam }}</td>
                        <td>{{ $instructeur->Mobiel }}</td>
                        <td>{{ \Illuminate\Support\Carbon::parse($instructeur->DatumInDienst)->format('d-m-Y') }}</td>
                        <td class="stars">{{ $instructeur->AantalSterren }}</td>
                        <td>
                            <a class="icon-button" href="{{ route('instructeurs.voertuigen.index', $instructeur->Id) }}" title="Voertuigen bekijken" aria-label="Voertuigen bekijken">
                                &#128663;
                            </a>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</x-layout>
