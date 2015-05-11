// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:xliff_reader/xliff_reader.dart' as xliff_reader;
import 'dart:io';
import 'package:xml/xml.dart';

Map<String, String> LANGUAGE_CODE_MAP = 
// HERE
  const {
    "af-ZA": "af",
    "am-ET": "am",
    "ar-SA": "ar",
    "as-IN": "as",
    "bg-BG": "bg",
    "bn-IN": "bn",
    "bs-Latn-BA": "bs",
    "cs-CZ": "cs",
    "da-DK": "da",
    "de-DE": "de",
    "el-GR": "el",
    "en-GB": "en-GB",
    "en-CN": "remove",
    "en-US": "remove",
    "es-CO": "es-419",
    "es-ES": "es",
    "et-EE": "et",
    "fa-IR": "fa",
    "fi-FI": "fi",
    "fr-CA": "fr-CA",
    "fr-FR": "fr",
    "ga-IE": "ga",
    "gu-IN": "gu",
    "ha-Latn-NG": "ha",
    "he-IL": "iw",
    "hi-IN": "hi",
    "hr-HR": "hr",
    "hu-HU": "hu",
    "id-ID": "id",
    "it-IT": "it",
    "ja-JP": "ja",
    "kk-Cyrl-KZ": "kk",
    "kn-IN": "kn",
    "ko-KR": "ko",
    "ku-Arab-IQ": "ku",
    "lt-LT": "lt",
    "lv-LV": "lv",
    "mk-MK": "mk",
    "ml-IN": "ml",
    "mn-Cyrl-MN": "mn",
    "mr-IN": "mr",
    "ms-MY": "ms",
    "nb-NO": "no",
    "nl-NL": "nl",
    "pa-IN": "pa",
    "pl-PL": "pl",
    "pt-BR": "pt-BR",
    "pt-PT": "pt-PT",
    "or-IN": "or",
    "ro-RO": "ro",
    "ru-RU": "ru",
    "sk-SK": "sk",
    "sl-SI": "sl",
    "sq-AL": "sq",
    "sr-Latn-RS": "sr",
    "sv-SE": "sv",
    "ta-IN": "ta",
    "te-IN": "te",
    "th-TH": "th",
    "tr-TR": "tr",
    "uk-UA": "uk",
    "ur-IN": "ur",
    "uz-Cyrl-UZ": "remove",
    "uz-Latn-UZ": "uz",
    "vi-VN": "vi",
    "zh-Hans-CN": "zh-CN",
    "zh-Hant-HK": "zh-HK",
    "zh-Hant-TW": "zh-TW"
  };

main(List<String> arguments) {
  String original = new File('/home/sungguk/program_store/localization-data_2/tvguide.xliff').readAsStringSync();
  var document = parse(original);
  var translated_text = "";
  var to_write_text = "";
  var expected_file_name = "";
  document.descendants.forEach((element) {
    // Exactly 
    //if (element.toString() == arguments[0]) {
    if (element.toString() == "Input Blocked") {
      var preced = element.ancestors;
      for(var i in preced) {
        var parent2 = i.ancestors;
        for(var j in parent2) {
          var target_element = j.findElements("target");
          translated_text = target_element.single.text;
          //print("NIKE: " + j.toString());
          var parent_parent = j.ancestors;
          var pparnet = parent_parent.first.ancestors;
          for (var k in pparnet) {
            for(var z in k.attributes) {
             if(z.toString().contains("target-language")) {
              //print("<translation id=\"{0}" + "\">" + translated_text + "</translation>");
               to_write_text = "<translation id=\"7666559633534040881" + "\">" + translated_text + "</translation>";
               //print("<translation id=\"8517434622200999683" + "\">" + translated_text + "</translation>");
               print(z.toString());
               expected_file_name = z.toString().replaceFirst("target-language=\"", "").replaceFirst("\"", "");
               expected_file_name = LANGUAGE_CODE_MAP[expected_file_name];
               //print(expected_file_name);
               var gen = new File("./ttest/generated_resources_" + expected_file_name + ".xtb");
               gen.writeAsStringSync(to_write_text);
             }
            }
            break;
          }
          break;
        }
        break;
      }
    }
  });
}
