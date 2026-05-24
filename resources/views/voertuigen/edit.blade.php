<x-layout title="Wijzigen voertuiggegevens">
    <section class="page-heading">
        <div>
            <h1>Wijzigen voertuiggegevens</h1>
        </div>
        <a class="button secondary" href="{{ route('instructeurs.voertuigen.index', $instructeur) }}">Terug</a>
    </section>

    <form class="form-panel wire-form" method="post" action="{{ route('instructeurs.voertuigen.update', [$instructeur, $voertuig->Id]) }}">
        @csrf
        @method('PUT')

        <label>
            Instructeur:
            <select name="InstructeurId" required>
                @foreach ($instructeurs as $rijInstructeur)
                    <option value="{{ $rijInstructeur->Id }}" @selected((int) old('InstructeurId', $voertuig->InstructeurId ?? $instructeur->Id) === $rijInstructeur->Id)>
                        {{ $rijInstructeur->VolledigeNaam }}
                    </option>
                @endforeach
            </select>
        </label>

        <label>
            Type voertuig:
            <select name="TypeVoertuigId" required>
                @foreach ($typeVoertuigen as $typeVoertuig)
                    <option value="{{ $typeVoertuig->Id }}" @selected((int) old('TypeVoertuigId', $voertuig->TypeVoertuigId) === $typeVoertuig->Id)>
                        {{ $typeVoertuig->TypeVoertuig }}
                    </option>
                @endforeach
            </select>
        </label>

        <label>
            Type:
            <input name="Type" value="{{ old('Type', $voertuig->Type) }}" required>
            @error('Type')<span class="error">{{ $message }}</span>@enderror
        </label>

        <label>
            Bouwjaar:
            <input value="{{ \Illuminate\Support\Carbon::parse($voertuig->Bouwjaar)->format('d-m-Y') }}" readonly>
        </label>

        <fieldset class="radio-group">
            <legend>Brandstof:</legend>
            @foreach ($brandstoffen as $brandstof)
                <label>
                    <input type="radio" name="Brandstof" value="{{ $brandstof }}" @checked(old('Brandstof', $voertuig->Brandstof) === $brandstof) required>
                    {{ $brandstof }}
                </label>
            @endforeach
            @error('Brandstof')<span class="error">{{ $message }}</span>@enderror
        </fieldset>

        <label>
            Kenteken:
            <input name="Kenteken" value="{{ old('Kenteken', $voertuig->Kenteken) }}" maxlength="10" required>
            @error('Kenteken')<span class="error">{{ $message }}</span>@enderror
        </label>

        <div class="form-actions">
            <button class="button" type="submit">Wijzig</button>
        </div>
    </form>
</x-layout>
