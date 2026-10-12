# Simulare Unitate Autonomă de Decizie - Gemini AI Core pentru Hubul Energetic

class GeminiEnergyCore:
    def __init__(self, zona_frontiera="Siria-Irak-Israel"):
        self.zona = zona_frontiera
        self.stare_conflict = False
        self.capacitate_livrare_mw = 1200.0 # 1.2 GW putere instalată
        
    def analizeaza_telemetrie_securitate(self, alerte_militare_detectate):
        """
        Simulează scanarea datelor satelitare și a rapoartelor de securitate în timp real.
        """
        if alerte_militare_detectate > 0:
            self.stare_conflict = True
            self.actioneaza_protocolul_de_criza()
        else:
            self.stare_conflict = False
            print(f"[Gemini AI] Stare de PACE menținută în zona {self.zona}. Livrare energie 100%.")
            
    def actioneaza_protocolul_de_criza(self):
        print(f"[ALERTĂ GEMINI AI] Conflict detectat în sectorul {self.zona}! Se activează protocolul Energy-for-Peace.")
        self.capacitate_livrare_mw = 0.0
        print("[SMART CONTRACT TRIGGERED] Fluxul de energie a fost sistat automat. Randamentele $ENEX sunt oprite.")

if __name__ == "__main__":
    oracol_ai = GeminiEnergyCore()
    
    print("--- Test 1: Funcționare normală (Pace) ---")
    oracol_ai.analizeaza_telemetrie_securitate(alerte_militare_detectate=0)
    
    print("\n--- Test 2: Detectare conflict regional ---")
    oracol_ai.analizeaza_telemetrie_securitate(alerte_militare_detectate=2)
