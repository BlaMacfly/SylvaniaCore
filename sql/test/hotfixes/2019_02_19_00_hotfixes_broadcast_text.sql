DELETE FROM broadcast_text WHERE ID IN (130826, 130856, 132489, 134034, 147278, 147279);
INSERT INTO broadcast_text (ID, Text, Text1, EmotesID, SoundEntriesID1, SoundEntriesID2, VerifiedBuild) VALUES
(130826, "We will soon see if the Horde heeds Velen's call. Those savages lack any sense of honor, but they do know how to fight.", "", 0, 0, 87088, 25996),
(130856, "We must find the Army of the Light. With them fighting alongside us, the Legion will fall. We must find...", "", 1, 86878, 0, 25996),
(132489, "Your mother and father yet live, Arator. I am sure of it. But for now, stay focused on the fight to come.", "", 1, 87998, 0, 25996),
(134034, "I am ready.", "I am ready.", 0, 0, 0, 25996),
(147278, "Beneath the shadow of the darkened spire, there is no light, no mercy, only void, and the chaos within.", "", 0, 0, 0, 0),
(147279, "Right away, General!", "", 0, 0, 0, 0);
DELETE FROM broadcast_text_locale WHERE ID IN (130826, 130856, 132489, 134034, 147278, 147279);
INSERT INTO broadcast_text_locale (ID, locale, Text_lang, Text1_lang) VALUES
(130826, "ruRU", "Скоро мы узнаем, ответит ли Орда на призыв Велена. У них нет чувства долга, но сражаться они умеют.", ""),
(130856, "ruRU", "Нужно отыскать Армию Света. Если объединить наши силы, Легион падет. Мы должны найти...", ""),
(132489, "ruRU", "Аратор, я уверен, что твои родители живы. Но сейчас сосредоточься на предстоящей битве.", ""),
(134034, "ruRU", "Я готов.", "Я готова."),
(147278, "ruRU", "В тени темного шпиля нет ни света, ни милосердия, внутри только пустота и хаос.", ""),
(147279, "ruRU", "Сейчас же, Генерал!", "");
