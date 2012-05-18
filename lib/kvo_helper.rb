module KVOHelper
  
    def observe(target, key_path, &block)
      @observers = {} if @observers.nil?
      @observers[key_path] = { target:target, block:block }
      target.addObserver(self, forKeyPath:key_path, options:NSKeyValueObservingOptionNew, context:nil)
    end
    
    def observe_old(target, key_path, &block)
      @observers = {} if @observers.nil?
      @observers[key_path] = { target:target, block:block }
      target.addObserver(self, forKeyPath:key_path, options:NSKeyValueObservingOptionOld, context:nil)
    end
  
    def unobserve(target, key_path)
      target.removeObserver(self, forKeyPath:key_path)
      @observers[key_path] = nil
    end
  
    def remove_all_observers
      @observers.each do |key_path, observer|
        unobserve(observer[:target], key_path)
      end
    end
  
    # NSKeyValueObserving Protocol
    
    def observeValueForKeyPath(key_path, ofObject:object, change:change, context:context)
      observer = @observers[key_path]
      observer[:block].call(object) unless (observer.nil? && observer[:block].nil?)
    end
    
end
