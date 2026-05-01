import AVFoundation
import Foundation

guard CommandLine.arguments.count == 3 else {
  fputs("Usage: swift export_video.swift input.mov output.mp4\n", stderr)
  exit(2)
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

try? FileManager.default.removeItem(at: outputURL)

let asset = AVURLAsset(url: inputURL)
let preset = AVAssetExportPreset1280x720

guard AVAssetExportSession.exportPresets(compatibleWith: asset).contains(preset) else {
  fputs("Preset 1280x720 is not compatible with this video.\n", stderr)
  exit(3)
}

guard let export = AVAssetExportSession(asset: asset, presetName: preset) else {
  fputs("Could not create export session.\n", stderr)
  exit(4)
}

export.outputURL = outputURL
export.outputFileType = .mp4
export.shouldOptimizeForNetworkUse = true

let semaphore = DispatchSemaphore(value: 0)
export.exportAsynchronously {
  semaphore.signal()
}
semaphore.wait()

switch export.status {
case .completed:
  print("Exported \(outputURL.path)")
case .failed:
  fputs("Export failed: \(export.error?.localizedDescription ?? "unknown error")\n", stderr)
  exit(5)
case .cancelled:
  fputs("Export cancelled.\n", stderr)
  exit(6)
default:
  fputs("Export ended with status \(export.status.rawValue).\n", stderr)
  exit(7)
}
