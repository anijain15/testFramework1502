//
//  PerformaneModel.swift
//  WynkMusicUITests
//
//  Created by B0218201 on 16/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation

struct PerfModel: Encodable
{
    var scenarioName: String
    var featureName : String
    var status : String
    var duration: Double
    var env: String
    var testReportUrl: String?
    var appinfo: appInfo
    var device: device?
    var metrics: metrics
    
    enum CodingKeys: String, CodingKey
    {
        case scenarioName, featureName, status,duration, env, testReportUrl, appinfo = "app", device, metrics
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(scenarioName, forKey: .scenarioName)
        try container.encodeIfPresent(featureName, forKey: .featureName)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(env, forKey: .env)
        try container.encodeIfPresent(testReportUrl, forKey: .testReportUrl)
        try container.encodeIfPresent(appinfo, forKey: .appinfo)
        try container.encodeIfPresent(device, forKey: .device)
        try container.encodeIfPresent(metrics, forKey: .metrics)
    }
    
}

struct appInfo : Encodable{
    var name:String
    var version: String
    var appVersion : String
    var buildNumber : String
    
    enum CodingKeys: String, CodingKey
    {
        case name, version, appVersion,buildNumber
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(version, forKey: .version)
        try container.encodeIfPresent(appVersion, forKey: .appVersion)
        try container.encodeIfPresent(buildNumber, forKey: .buildNumber)
        
    }
}

struct device: Encodable
{
    var type:String
    var name: String
    var networkType: String
    var os : String
    var deviceOperator: String
    var manufacturer: String
    var model: String
    var hardware: String
    var cpuAbi: String
    var sdkVersion: String
    var totalDeviceStorage: String
    var ram: String
    
    enum CodingKeys: String, CodingKey
    {
        case type,name, networkType,os,deviceOperator = "operator", manufacturer, model, hardware,
        cpuAbi, sdkVersion, totalDeviceStorage,ram
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(type, forKey: .type)
         try container.encodeIfPresent(networkType, forKey: .networkType)
         try container.encodeIfPresent(os, forKey: .os)
        try container.encodeIfPresent(deviceOperator, forKey: .deviceOperator)
         try container.encodeIfPresent(manufacturer, forKey: .manufacturer)
         try container.encodeIfPresent(model, forKey: .model)
         try container.encodeIfPresent(hardware, forKey: .hardware)
        try container.encodeIfPresent(cpuAbi, forKey: .cpuAbi)
        try container.encodeIfPresent(sdkVersion, forKey: .sdkVersion)
        try container.encodeIfPresent(totalDeviceStorage, forKey: .totalDeviceStorage)
        try container.encodeIfPresent(ram, forKey: .ram)
        
        
        
    }
    
    
}


struct  metrics: Encodable {
    var max_cpu_utilized: Float
    var max_mem_consumed: Float
    var max_native_heap_consumed: Float
    var max_code_heap_consumed: Float
    var max_java_heap_consumed: Float
    var janky_frames: Float
    var storage_consumed_before_start:Float
    var storage_consumed: Float
    var data_consumed:Float
    var apkanalyser:apkanalyser
    var click_to_play:click_to_play
    
    enum CodingKeys: String, CodingKey
      {
          case name, version, appVersion,buildNumber, apkanalyser,click_to_play,max_cpu_utilized, max_mem_consumed,
        max_native_heap_consumed, max_java_heap_consumed,max_code_heap_consumed, janky_frames, storage_consumed_before_start,storage_consumed,data_consumed
      }
    
        func encode(to encoder: Encoder) throws
        {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(apkanalyser, forKey: .apkanalyser)
            try container.encodeIfPresent(click_to_play, forKey: .click_to_play)
            try container.encodeIfPresent(max_cpu_utilized, forKey: .max_cpu_utilized)
            try container.encodeIfPresent(max_mem_consumed, forKey: .max_mem_consumed)
            
            try container.encodeIfPresent(max_native_heap_consumed, forKey: .max_native_heap_consumed)
            try container.encodeIfPresent(max_java_heap_consumed, forKey: .max_java_heap_consumed)
            try container.encodeIfPresent(max_code_heap_consumed, forKey: .max_code_heap_consumed)
            try container.encodeIfPresent(janky_frames, forKey: .janky_frames)
            try container.encodeIfPresent(storage_consumed_before_start, forKey: .storage_consumed_before_start)
            try container.encodeIfPresent(storage_consumed, forKey: .storage_consumed)
            try container.encodeIfPresent(data_consumed, forKey: .data_consumed)
         }
}

struct apkanalyser: Encodable {
    var apk_external_size:Float
    var initial_app_cache:Float
    var initial_app_installed_size:Float
    var initial_app_data:Float
    var final_app_cache:Float
    var final_app_installed_size:Float
    var final_app_data:Float
    
    enum CodingKeys: String, CodingKey
     {
         case apk_external_size, initial_app_cache, initial_app_installed_size, initial_app_data, final_app_cache,
        final_app_installed_size, final_app_data
     }
    
     func encode(to encoder: Encoder) throws
     {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(apk_external_size, forKey: .apk_external_size)
        try container.encodeIfPresent(initial_app_cache, forKey: .initial_app_cache)
        try container.encodeIfPresent(initial_app_installed_size, forKey: .initial_app_installed_size)
        try container.encodeIfPresent(initial_app_data, forKey: .initial_app_data)
        try container.encodeIfPresent(final_app_cache, forKey: .final_app_cache)
        try container.encodeIfPresent(final_app_installed_size, forKey: .final_app_installed_size)
        try container.encodeIfPresent(final_app_data, forKey: .final_app_data)
        
     }
}

struct  click_to_play: Encodable {
    var LIONSGATEPLAY: Double
    
    enum CodingKeys: String, CodingKey
    {
        case LIONSGATEPLAY
    }
   
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(LIONSGATEPLAY, forKey: .LIONSGATEPLAY)
    }
}
